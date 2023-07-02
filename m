Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56257745069
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Jul 2023 21:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGBTgJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 Jul 2023 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTgI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Jul 2023 15:36:08 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 12:36:05 PDT
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6252BA6;
        Sun,  2 Jul 2023 12:36:05 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 362Hti7l025943;
        Sun, 2 Jul 2023 12:55:44 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 362HtgD4025942;
        Sun, 2 Jul 2023 12:55:42 -0500
Date:   Sun, 2 Jul 2023 12:55:42 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [QUESTION] Full user space process isolation?
Message-ID: <20230702175542.GA25867@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com> <20230629021000.GA368825@mail.hallyn.com> <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 02 Jul 2023 12:55:44 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 29, 2023 at 10:11:26AM +0200, Roberto Sassu wrote:

Good morning, I hope the weekend is going well for everyone, greetings
to Roberto and everyone copied.

> On Wed, 2023-06-28 at 21:10 -0500, Serge E. Hallyn wrote:
> > On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
> > > Hi everyone
> > > 
> > > I briefly discussed this topic at LSS NA 2023, but I wanted to have an
> > > opinion from a broader audience.
> > > 
> > > In short:
> > > 
> > > I wanted to execute some kernel workloads in a fully isolated user
> > > space process, started from a binary statically linked with klibc,
> > > connected to the kernel only through a pipe.
> > > 
> > > I also wanted that, for the root user, tampering with that process is
> > > as hard as if the same code runs in kernel space.
> > > 
> > > I would use the fully isolated process to parse and convert unsupported
> > > data formats to a supported one, after the kernel verified the
> > 
> > Can you give some examples here of supported and unsupported data
> > formats?  ext2 is supported, but we sadly don't trust the sb parser
> > to read a an ext2fs coming from unknown source.  So I'm not quite
> > clear what problem you're trying to solve.
> 
> + eBPF guys (as I'm talking about eBPF)

If the week goes well, we will be submitting the second version of our
TSEM LSM for review.  It incorporates a significant number of changes
and enhancements, based on both initial review comments, and
importantly, feedback from our collaborators in the critical
infrastructure community.

Just as a levelset.  TSEM provides kernel infrastructure to implement
security controls based on either deterministic or machine learning
models.  Quixote is the userspace infrastructure that enables use of
the TSEM kernel infrastructure.

Based on your description Roberto, TSEM may be of assistance in
addressesing your issues at two different levels.

First with respect to protection of an isolated workload.

TSEM is inherently workload based, given that it is based on an
architecture that implements security modeling namespaces that a
process heirarchy can be placed into.  This reduces model complexity
and provides the implementation of very specific and targeted security
controls based on the needs of a proposed workload.

The security controls are prospective rather than retrospective,
ie. TSEM will pro-actively block any security behaviors that are not
in a security model that has been defined for the workload.

For example, with respect to the concerns you had previously mentioned
about ptrace.  If the security model definition does not include a
security state coefficient for a ptrace_traceme security event, it
will be disallowed, regardless of what goes on with respect to kernel
development, modulo of course the ptrace_traceme LSM hook being
discontinued.

Cross-model signaling is blocked by default, which further restricts
what can happen in a workload to the workload itself.  The security
event coefficients are generated based on a concept known as a 'task
identity'.  The documentation has extensive details on this, but the
effect is to make the security behaviors specific to the identity of
the executable code that requests modeling of security events.

So what one ends up with are security controls that contrains the
behavior of the workload to be as consistent as possible to what the
workload has been unit tested to.

Decision making for the security behavior is embodied in an entity
known as a Trust Modeling Agent (TMA).  The architecture is designed
to be flexible with respect to where the TMA is run.  The sample
userspace provides TMA's that run in the kernel, a userspace process,
an SGX enclave, a Xen based stubdomain and several micro-controller
implementations.

Lots more details, but I will not drone on further, the TSEM
implementation comes with about 25 pages of documentation discussing
the architecture.

> File digests are distributed in a multitude of formats: RPM packages
> provide them in RPMTAG_FILEDIGESTS, DEB packages in md5sum (now
> sha256sum), containers I guess they have a manifest.
> 
> File digests would be used as reference values for IMA Appraisal and
> IMA Measurement (to have a predictable PCR).
> 
> If we manage to write a tiny parser for RPM headers (I'm talking about
> something like 200 lines) to extract the file digests, basically we
> have all the information we need to do IMA Appraisal on current, past
> and future RPM-based Linux distributions.
> 
> If we do the same for DEB (ok, well, when they switch from MD5 to
> SHA256), we can support all DEB-based Linux distributions too.
> 
> On the opposite side, yes, we can change the RPM format, ask the
> distributions to sign per-file. If it was that easy, we would not be
> (still) waiting for the first distribution (Fedora 38) to support file
> signatures since 2016, when the feature was proposed (sorry if it looks
> like diminishing what Mimi and IBM proposed, I'm trying to convey the
> idea of how difficult is to realize that architecture).
> 
> What about other formats? How long it could take for them to be adapted
> to store file signatures?
> 
> Immediate support for IMA Appraisal is as far as looping into the RPM
> header sections to obtain the data offset of RPMTAG_FILEDIGESTS and
> converting the digests at that offset from hex to bin (we need also to
> verify the PGP signature of the RPM header, but I would leave it for
> later).
> 
> You probably also see how close we are to accomplish the goal. I'm open
> to suggestions: if this idea of an isolated process doing the parsing
> is not suitable, I could implement it in a different way.
> 
> So far I proposed:
> 
> - In-kernel parser (dangerous, not scalable)
> https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/
> - eBPF (no program signatures, not compliant with the LSM conventions,
>   unsolved security issues)
> https://github.com/robertosassu/diglim-ebpf/commit/693745cb388bca7354233cadae1fe2d23d47ff9d
> - Isolated user space process (not enough isolation guarantees)
> https://lore.kernel.org/linux-kernel//20230317145240.363908-1-roberto.sassu@huaweicloud.com/
> https://lore.kernel.org/linux-kernel//20230425173557.724688-1-roberto.sassu@huaweicloud.com/

Quixote/TSEM is the product of a number of years of our team building
secure systems based on IMA, TPM's, TBOOT and SGX.  Its design was
largely driven by the challenges that we ran into when trying to put
these implementations into field operation.

If you want to look at options beyond classic IMA and appraisal,
Quixote/TSEM may be of utility beyond just the protection of your
proposed single-purpose parsing process.

Given the issues posed, in particular by SMP systems, we designed
Quixote/TSEM from the ground up to deal with the challenges of time
dependent linear extension measurements, ie. the TPM PCR model.  The
Quixote deterministic and quasi-deterministic models are designed to
provide an invariant functional 'state' value for the security status
of a workload, a value that is scheduling independent.

One of the basis parameters for TSEM modeling is the digest value of
either an executable file or memory that has been marked as
executable, the same model used by IMA.  In essence you get file
appraisal for 'free', as a result of modeling the security behavior of
a workload.

The bearers token for the security of a workload is a signed security
model generated by unit testing of the workload.  If the file digests
generated by workload execution are inconsistent with what has been
unit tested for the workload, the security state goes out of model
definition and is detected and/or blocked.

The only thing that needs to know about keys and signatures is the
Quixote trust orchestrator and the security model definition, all of
which further reduces the distribution complexity of the model.

So Quixote/TSEM provides an alternate architecture where the desired
security state of a workload is provided in some type of workload or
container manifest, not just in the form of file digests.  This
architecture should be of interest to Lennart and the systemd group as
well as the container people.

One of the open questions is the notion of establishing a definition
for trust.  For example, the 'BPF token' thread, has talked about the
notion of what is a 'trusted' process, discussions on the lockdown LSM
focused on that as well.  In TSEM, a workload is 'trusted' by virtue
of not having generating a security state coefficient outside the
bounds of a pre-defined model for a workload.  Once it does so, it
will be treated as untrustworthy.

Lots and lots of additional details that I can speak to but this has
grown long already and I want to get out fishing.  I can speak in
probably boring detail on any additional questions that you may
have... :-)

> Thanks
> 
> Roberto

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
