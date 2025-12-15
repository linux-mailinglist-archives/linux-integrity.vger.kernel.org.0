Return-Path: <linux-integrity+bounces-7988-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247FCBDDFE
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 13:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 263A830762CB
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751352C11C5;
	Mon, 15 Dec 2025 12:41:45 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899E257AEC;
	Mon, 15 Dec 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802505; cv=none; b=VZz3PjtBZ7/CcPylOgzOFsjoruzQ6GC4iIKaDUHUEozn42ItfvMp0tHWxIReLb1TnAEcXN++x8GoIX6sV4gdSiMHfiAopulYAiYwQlUbAMEN8ubbcjTjWvOEmJal7QHFE0syRhEDG22hj3UTMH3VPW5YnkozLByu1ZAoYZ+QPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802505; c=relaxed/simple;
	bh=rdE/6cZ/6KdpW7XLUHDsAQWV7nAAUwM2+LrIbpi625Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pp5Otazy+7RZdT1B3lxMZfe8Ypl54vIK++l2s/HHaK6fAs7vXrHJObUrnqafKVcHzzHVGr1b1Aq3Mub15lpGubKlrvT1G3+gdQjc8EOv22NBIVRnywKUKgUfuZFsuckU8nClbs6MTwmWqkJM5u3c2XEN2Dhj2XNT6twznk8WvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVKQP5h3Yz1HC9R;
	Mon, 15 Dec 2025 20:39:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 86CC440568;
	Mon, 15 Dec 2025 20:41:39 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX0wX4AUBpmMgkAA--.42771S2;
	Mon, 15 Dec 2025 13:41:39 +0100 (CET)
Message-ID: <fbe8a62785626e324278892ecfd8a4112cdbac6f.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 15 Dec 2025 13:41:26 +0100
In-Reply-To: <CAHC9VhRUQxayj=XcdfbfHka-=N+B8cNk7Grg3QWGOTOz3BKfgw@mail.gmail.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhRUQxayj=XcdfbfHka-=N+B8cNk7Grg3QWGOTOz3BKfgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCX0wX4AUBpmMgkAA--.42771S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW7Gw4UJr45WF13Xr47Arb_yoW3AFyfpa
	y3W340kr4kJ348twn7Jw4ku3yF9w1kta1UJrn8t343A3W5CFW0kFWak3yYvFZIyr18t3Wj
	ywnIgrZ8J3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBGk-fpcGmAAAsk

On Fri, 2025-12-12 at 21:06 -0500, Paul Moore wrote:
> On Fri, Dec 12, 2025 at 12:19=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the ability of staging the entire (or a portion of the) IMA
> > measurement list for deletion. Staging means moving the current content=
 of
> > the measurement list to a separate location, and allowing users to read=
 and
> > delete it. This causes the measurement list to be atomically truncated
> > before new measurements can be added. Staging can be done only once at =
a
> > time. In the event of kexec(), staging is reverted and staged entries w=
ill
> > be carried over to the new kernel.
> >=20
> > User space is responsible to concatenate the staged IMA measurements li=
st
> > portions following the temporal order in which the operations were done=
,
> > together with the current measurement list. Then, it can send the colle=
cted
> > data to the remote verifiers.
> >=20
> > Also introduce the ability of trimming N measurements entries from the =
IMA
> > measurements list, provided that user space has already read them. Trim=
ming
> > combines staging and deletion in one operation.
> >=20
> > The benefit of these solutions is the ability to free precious kernel
> > memory, in exchange of delegating user space to reconstruct the full
> > measurement list from the chunks. No trust needs to be given to user sp=
ace,
> > since the integrity of the measurement list is protected by the TPM.
> >=20
> > By default, staging/trimming the measurements list does not alter the h=
ash
> > table. When staging/trimming are done, IMA is still able to detect
> > collisions on the staged and later deleted measurement entries, by keep=
ing
> > the entry digests (only template data are freed).
> >=20
> > However, since during the measurements list serialization only the SHA1
> > digest is passed, and since there are no template data to recalculate t=
he
> > other digests from, the hash table is currently not populated with dige=
sts
> > from staged/deleted entries after kexec().
> >=20
> > Introduce the new kernel option ima_flush_htable to decide whether or n=
ot
> > the digests of staged measurement entries are flushed from the hash tab=
le.
> >=20
> > Then, introduce ascii_runtime_measurements_staged_<algo> and
> > binary_runtime_measurement_staged_<algo> interfaces to stage/trim/delet=
e
> > the measurements. Use 'echo A > <IMA interface>' and
> > 'echo D > <IMA interface>' to respectively stage and delete the entire
> > measurements list. Use 'echo N > <IMA interface>', with N between 1 and
> > LONG_MAX, to stage the selected portion of the measurements list, and
> > 'echo -N > <IMA interface>' to trim N measurements entries.
>=20
> In an effort to help preserve the sanity of admins, I might suggest
> avoiding commands that start with a dash/'-'.  I'd probably also
> simplify the commands a bit and drop all/'A' since the measurement
> list could change at any time, stick with an explicit number and just
> let the admin go over, e.g. write LONG_MAX, which effectively becomes
> 'A'.  I think you could do everything you need with just two commands:
>=20
>   <NUM>: stage <NUM> entries
>       D: delete staged entries

If the goal is that the verifier always receives a TPM quote aligned
with the measurements, the remote attestation agent in the target
system has to walk over the measurements to find N.

The difference between the approach I was suggesting and Steven's is
that I calculate N after staging all measurements and store the
exceeding measurements locally until the next attestation request. If
the verifier supports it, the exceeding measurements could be stored
also there.

That means that I don't need to walk in the measurement list to stage,
because I stage the entire list (with list_replace()). I do a walk
after detaching, without interfering with the processes adding new
measurements (hot path).

Steven's approach is to read the measurements list to calculate N and
stage/trim the measurement based on N. As Steven/Gregory pointed out,
at this point you could already trim N because you already have the
measurements list.

However, in this case you have to walk through the measurements list as
an RCU reader in the hot path, calculate N, and walk through the
measurements list again as an RCU writer in the hot path to stage/trim
N. In the next attestation request, you would read the previous
exceeding measurements again.

One major obstacle of my approach, as Gregory pointed out, was that
staged measurements were not carried over during kexec(). While I
thought about coordinating remote attestation requests with kexec() in
a management engine, there can be cases where this is harder to
achieve.

I managed to solve that by introducing a third linked list containing
the measurements to delete, by doing another list replace between
staged and measurements to delete (when the 'D' command is issued),
under the hot path lock. That allowed me to take the hot path lock
during kexec() and prepend the staged measurements before the non-
staged ones (that reminded me that I should properly inform user space=20
if kexec() consumed staged measurements before the 'D' command was
executed, i.e. it lost the race with kexec()).

The approach to keep the stage N approach would be necessary if
exceeding measurements cannot be stored either locally or at the
verifier side.

For me it would be fine to keep both approaches, but I still see
advantages of the stage all approach.

Thanks

Roberto

> I intentionally left out the trim/'T' command, because I'm not sure it
> is really necessary if you are going to implement the phased
> stage/delete process.  Yes, you have to do two operations (stage and
> delete) as opposed to just the trim, but I'd probably take the
> simplicity of just supporting a single approach over the trivial
> necessity of having to do two operations in userspace.
>=20
> Staging also has the benefit of having a sane way of handling two
> tasks racing to stage the measurement list.  I could see cases where
> multiple tasks race to trim the list and end up trimming more than was
> intended since they both hit in sequence.
>=20
> If you did want to take a trim approach over a stage/delete approach,
> I could see something like this working:
>=20
>  1. process opens the measurement list
>  2. process reads from the measurement list, keeps the fd open
>  3. process does whatever it wants to preserve the list
>  4. process writes <NUM> to the measurement list, kernel trims <NUM> entr=
ies
>  5. process closes fd
>=20
> ... error handling shouldn't be too bad.  The process only writes
> <NUM> to the fd if it has already finished whatever it needs to do to
> preserve the list outside the kernel, think of it as a "commit"
> operation on a transaction.  If the fd is closed for some reason
> (error, interruption, killed) before the process writes <NUM> to the
> fd then IMA does nothing - no trim takes place.
>=20
> Multiple process racing can easily be solved when the log is opened;
> only one open(O_RDWR) is allowed at a time, other racing processes
> will get EBUSY.  Yes, one process could block others from trimming by
> holding the fd open for an extended period of time, but I would expect
> that CAP_SYS_ADMIN and root fs perms would be required to open the log
> read/write (not to mention any LSM access rights in place).
>=20
> I know I mentioned this basic idea to someone at some point, but there
> have been various discussion threads and multiple people over a fairly
> lengthy time that I've lost track of where it was mentioned.  If it
> was already discussed on-list and rejected for a good reason you can
> simply ignore the above approach ... although I still think the
> stage/delete API could be simplified as described :)
>=20
> [UPDATE: as I'm reading Steven's replies it looks like he has proposed
> something very similar to the above]
>=20


