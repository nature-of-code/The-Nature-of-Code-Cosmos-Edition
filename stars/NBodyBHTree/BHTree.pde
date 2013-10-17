public class BHTree {
  private Body body;     // body or aggregate body stored in this node
  private Quad quad;     // square region that the tree represents
  private BHTree NW;     // tree representing northwest quadrant
  private BHTree NE;     // tree representing northeast quadrant
  private BHTree SW;     // tree representing southwest quadrant
  private BHTree SE;     // tree representing southeast quadrant
  
  //Create and initialize a new bhtree. Initially, all nodes are null and will be filled by recursion
  //Each BHTree represents a quadrant and a body that represents all bodies inside the quadrant
  public BHTree(Quad q) {
    this.quad=q;
    this.body=null;
    this.NW=null;
    this.NE=null;
    this.SW=null;
    this.SE=null;
  }
  //If all nodes of the BHTree are null, then the quadrant represents a single body and it is "external"
  public Boolean isExternal(BHTree t) {
    if (t.NW==null && t.NE==null && t.SW==null && t.SE==null) return true;
    else return false;
  }
  //We have to populate the tree with bodies. We start at the current tree and recursively travel through the branches
  public void insert(Body b) {
    //If there's not a body there already, put the body there.
    if (this.body==null) {
      this.body=b;
    }
    //If there's already a body there, but it's not an external node
    //combine the two bodies and figure out which quadrant of the 
    //tree it should be located in. Then recursively update the nodes below it.
    else if (this.isExternal(this)==false) {
      this.body=add(this.body,b);
      
      Quad northwest = this.quad.NW();
      if (b.in(northwest)) {
        if (this.NW==null) {this.NW= new BHTree(northwest);}
        NW.insert(b);    
      }
      else {
        Quad northeast = this.quad.NE();
        if (b.in(northeast)) {
          if (this.NE==null) {this.NE= new BHTree(northeast);}
          NE.insert(b);
        }
        else {
          Quad southeast = this.quad.SE();
          if (b.in(southeast)) {
            if (this.SE==null) {this.SE= new BHTree(southeast);}
            SE.insert(b);
          } 
          else {
            Quad southwest = this.quad.SW();
            if(this.SW==null) {this.SW= new BHTree(southwest);}
            SW.insert(b);
          }
        }
      }
    }
    //If the node is external and contains another body, create BHTrees
    //where the bodies should go, update the node, and end 
    //(do not do anything recursively)
    else if (this.isExternal(this)) {
      Body c = this.body;
      Quad northwest = this.quad.NW();
      if (c.in(northwest)) {
        if (this.NW==null) {this.NW= new BHTree(northwest);}
        NW.insert(c);    
      }
      else {
        Quad northeast = this.quad.NE();
        if (c.in(northeast)) {
          if (this.NE==null) {this.NE= new BHTree(northeast);}
          NE.insert(c);
        }
        else {
          Quad southeast = this.quad.SE();
          if (c.in(southeast)) {
            if (this.SE==null) {this.SE= new BHTree(southeast);}
            SE.insert(c);
          } 
          else {
            Quad southwest = this.quad.SW();
            if(this.SW==null) {this.SW= new BHTree(southwest);}
            SW.insert(c);
          }
        }
      }
      this.insert(b);
    }
  }
  //Start at the main node of the tree. Then, recursively go each branch
  //Until either we reach an external node or we reach a node that is sufficiently
  //far away that the external nodes would not matter much.
  public void updateForce(Body b) {
    if (this.isExternal(this)) {
      if (this.body!=b) b.addForce(this.body);
    }
    else if (this.quad.length()/(this.body.distanceTo(b))<2){
      b.addForce(this.body);
    }
    else {
      if (this.NW!=null) this.NW.updateForce(b);
      if (this.SW!=null) this.SW.updateForce(b);
      if (this.SE!=null) this.SE.updateForce(b);
      if (this.NE!=null) this.NE.updateForce(b);
    }
  }
  // convert to string representation for output
  public String toString() {
    if(NE != null || NW!=null || SW!=null || SE!=null) return "*" + body + "\n" + NW + NE + SW + SE;
    else           return " " + body + "\n";
  }
}
