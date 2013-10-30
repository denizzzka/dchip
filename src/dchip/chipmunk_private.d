/*
 * Copyright (c) 2007-2013 Scott Lembcke and Howling Moon Software
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
module dchip.chipmunk_private;

import dchip.chipmunk;
import dchip.types;

// drey todo

//~ enum CP_HASH_COEF = 3344921057uL;

//~ cpHashValue CP_HASH_PAIR(T)(T a, T b)
//~ {
    //~ return cast(cpHashValue)a * CP_HASH_COEF ^ cast(cpHashValue)b * CP_HASH_COEF;
//~ }

//~ // TODO: Eww. Magic numbers.
//~ enum MAGIC_EPSILON = 1e-5;

struct cpArray
{
    int num, max;
    void** arr;
}

//~ cpArray* cpArrayNew(int size);

//~ void cpArrayFree(cpArray* arr);

//~ void cpArrayPush(cpArray* arr, void* object);
//~ void* cpArrayPop(cpArray* arr);
//~ void cpArrayDeleteObj(cpArray* arr, void* obj);
//~ cpBool cpArrayContains(cpArray* arr, void* ptr);

//~ void cpArrayFreeEach(cpArray * arr, void function(void*) freeFunc);

//~ cpConstraint* cpConstraintNext(cpConstraint* node, cpBody* bdy)
//~ {
    //~ return (node.a == bdy ? node.next_a : node.next_b);
//~ }

//~ enum CP_BODY_FOREACH_CONSTRAINT(string bdy, string var, string code)
    //~ = format("for (cpConstraint* %2$s = %1$s.constraintList; %2$s; %2$s = cpConstraintNext(%2$s, %1$s)) { %3$s }",
             //~ bdy, var, code);

//~ cpArbiter* cpArbiterNext(cpArbiter* node, cpBody* bdy)
//~ {
    //~ return (node.body_a == bdy ? node.thread_a.next : node.thread_b.next);
//~ }

//~ enum CP_BODY_FOREACH_ARBITER(string bdy, string var, string code)
    //~ = format("for (cpArbiter* %2$s = %1$s->arbiterList; %2$s; %2$s = cpArbiterNext(%2$s, %1$s)) { %3$s }",
             //~ bdy, var, code);

//~ enum CP_BODY_FOREACH_SHAPE(string bdy, string var, string code)
    //~ = format("for (cpShape* %2$s = %1$s.shapeList; %2$s; %2$s = %2$s.next) { %3$s }",
            //~ bdy, var, code);

//~ enum CP_BODY_FOREACH_COMPONENT(string root, string var, string code)
    //~ = format("for (cpBody* %2$s = %1$s; %2$s; %2$s = %2$s.node.next) { %3$s }",
             //~ root, var, code);

alias cpHashSetEqlFunc = cpBool function(void* ptr, void* elt);
alias cpHashSetTransFunc = void* function(void* ptr, void* data);

//~ cpHashSet* cpHashSetNew(int size, cpHashSetEqlFunc eqlFunc);
//~ void cpHashSetSetDefaultValue(cpHashSet* set, void* default_value);

//~ void cpHashSetFree(cpHashSet* set);

//~ int cpHashSetCount(cpHashSet* set);
//~ void* cpHashSetInsert(cpHashSet* set, cpHashValue hash, void* ptr, void* data, cpHashSetTransFunc trans);
//~ void* cpHashSetRemove(cpHashSet* set, cpHashValue hash, void* ptr);
//~ void* cpHashSetFind(cpHashSet* set, cpHashValue hash, void* ptr);

alias cpHashSetIteratorFunc = void function(void* elt, void* data);
//~ void cpHashSetEach(cpHashSet* set, cpHashSetIteratorFunc func, void* data);

alias cpHashSetFilterFunc = cpBool function(void* elt, void* data);
//~ void cpHashSetFilter(cpHashSet* set, cpHashSetFilterFunc func, void* data);

//~ //MARK: Body Functions

//~ void cpBodyAddShape(cpBody* bdy, cpShape* shape);
//~ void cpBodyRemoveShape(cpBody* bdy, cpShape* shape);
//~ void cpBodyRemoveConstraint(cpBody* bdy, cpConstraint* constraint);

//~ //MARK: Shape/Collision Functions

//~ // TODO should move this to the cpVect API. It's pretty useful.
//~ cpVect cpClosetPointOnSegment(const cpVect p, const cpVect a, const cpVect b)
//~ {
    //~ cpVect  delta = cpvsub(a, b);
    //~ cpFloat t     = cpfclamp01(cpvdot(delta, cpvsub(p, b)) / cpvlengthsq(delta));
    //~ return cpvadd(b, cpvmult(delta, t));
//~ }

//~ cpShape* cpShapeInit(cpShape* shape, const cpShapeClass* klass, cpBody* bdy);

//~ cpBool cpShapeActive(cpShape* shape)
//~ {
    //~ return shape.prev || (shape.bdy && shape.bdy.shapeList == shape);
//~ }

//~ int cpCollideShapes(const cpShape* a, const cpShape* b, cpCollisionID* id, cpContact* arr);

//~ void CircleSegmentQuery(cpShape* shape, cpVect center, cpFloat r, cpVect a, cpVect b, cpSegmentQueryInfo* info)
//~ {
    //~ cpVect da = cpvsub(a, center);
    //~ cpVect db = cpvsub(b, center);

    //~ cpFloat qa = cpvdot(da, da) - 2.0f * cpvdot(da, db) + cpvdot(db, db);
    //~ cpFloat qb = -2.0f * cpvdot(da, da) + 2.0f * cpvdot(da, db);
    //~ cpFloat qc = cpvdot(da, da) - r * r;

    //~ cpFloat det = qb * qb - 4.0f * qa * qc;

    //~ if (det >= 0.0f)
    //~ {
        //~ cpFloat t = (-qb - cpfsqrt(det)) / (2.0f * qa);

        //~ if (0.0f <= t && t <= 1.0f)
        //~ {
            //~ info.shape = shape;
            //~ info.t     = t;
            //~ info.n     = cpvnormalize(cpvlerp(da, db, t));
        //~ }
    //~ }
//~ }

//~ // TODO doesn't really need to be inline, but need a better place to put this function
//~ cpSplittingPlane cpSplittingPlaneNew(cpVect a, cpVect b)
//~ {
    //~ cpVect n = cpvnormalize(cpvperp(cpvsub(b, a)));
    //~ cpSplittingPlane plane = { n, cpvdot(n, a) };
    //~ return plane;
//~ }

//~ cpFloat cpSplittingPlaneCompare(cpSplittingPlane plane, cpVect v)
//~ {
    //~ return cpvdot(plane.n, v) - plane.d;
//~ }

//~ void cpLoopIndexes(cpVect* verts, int count, int* start, int* end);

//~ //MARK: Spatial Index Functions

//~ cpSpatialIndex* cpSpatialIndexInit(cpSpatialIndex* index, cpSpatialIndexClass* klass, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex* staticIndex);

//~ //MARK: Space Functions

//~ extern cpCollisionHandler cpDefaultCollisionHandler;
//~ void cpSpaceProcessComponents(cpSpace* space, cpFloat dt);

//~ void cpSpacePushFreshContactBuffer(cpSpace* space);
//~ cpContact* cpContactBufferGetArray(cpSpace* space);
//~ void cpSpacePushContacts(cpSpace* space, int count);

//~ struct cpPostStepCallback
//~ {
    //~ cpPostStepFunc func;
    //~ void* key;
    //~ void* data;
//~ }

//~ cpPostStepCallback* cpSpaceGetPostStepCallback(cpSpace* space, void* key);

//~ cpBool cpSpaceArbiterSetFilter(cpArbiter* arb, cpSpace* space);
//~ void cpSpaceFilterArbiters(cpSpace* space, cpBody* bdy, cpShape* filter);

//~ void cpSpaceActivateBody(cpSpace* space, cpBody* bdy);
//~ void cpSpaceLock(cpSpace* space);
//~ void cpSpaceUnlock(cpSpace* space, cpBool runPostStep);

//~ cpCollisionHandler* cpSpaceLookupHandler(cpSpace* space, cpCollisionType a, cpCollisionType b)
//~ {
    //~ cpCollisionType[2] types;
    //~ types[0] = a;
    //~ types[1] = b;

    //~ return cast(cpCollisionHandler*)cpHashSetFind(space.collisionHandlers, CP_HASH_PAIR(a, b), types);
//~ }

//~ void cpSpaceUncacheArbiter(cpSpace* space, cpArbiter* arb)
//~ {
    //~ cpShape* a = arb.a, b = arb.b;
    //~ cpShape*[2] shape_pair;
    //~ shape_pair[0] = a;
    //~ shape_pair[1] = b;
    //~ cpHashValue arbHashID = CP_HASH_PAIR(cast(cpHashValue)a, cast(cpHashValue)b);
    //~ cpHashSetRemove(space.cachedArbiters, arbHashID, shape_pair);
    //~ cpArrayDeleteObj(space.arbiters, arb);
//~ }

//~ void cpShapeUpdateFunc(cpShape* shape, void* unused);
//~ cpCollisionID cpSpaceCollideShapes(cpShape* a, cpShape* b, cpCollisionID id, cpSpace* space);

//~ //MARK: Arbiters

//~ struct cpContact
//~ {
    //~ cpVect p, n;
    //~ cpFloat dist;

    //~ cpVect r1, r2;
    //~ cpFloat nMass, tMass, bounce;

    //~ cpFloat jnAcc, jtAcc, jBias;
    //~ cpFloat bias;

    //~ cpHashValue hash;
//~ };

//~ cpContact* cpContactInit(cpContact* con, cpVect p, cpVect n, cpFloat dist, cpHashValue hash);
//~ cpArbiter* cpArbiterInit(cpArbiter* arb, cpShape* a, cpShape* b);

//~ void cpArbiterCallSeparate(cpArbiter* arb, cpSpace* space)
//~ {
    //~ // The handler needs to be looked up again as the handler cached on the arbiter may have been deleted since the last step.
    //~ cpCollisionHandler* handler = cpSpaceLookupHandler(space, arb.a.collision_type, arb.b.collision_type);
    //~ handler.separate(arb, space, handler.data);
//~ }

//~ cpArbiterThread* cpArbiterThreadForBody(cpArbiter* arb, cpBody* bdy)
//~ {
    //~ return (arb.body_a == bdy ? &arb.thread_a : &arb.thread_b);
//~ }

//~ void cpArbiterUnthread(cpArbiter* arb);

//~ void cpArbiterUpdate(cpArbiter* arb, cpContact* contacts, int numContacts, cpCollisionHandler* handler, cpShape* a, cpShape* b);
//~ void cpArbiterPreStep(cpArbiter* arb, cpFloat dt, cpFloat bias, cpFloat slop);
//~ void cpArbiterApplyCachedImpulse(cpArbiter* arb, cpFloat dt_coef);
//~ void cpArbiterApplyImpulse(cpArbiter* arb);
