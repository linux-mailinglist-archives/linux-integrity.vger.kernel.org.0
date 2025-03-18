Return-Path: <linux-integrity+bounces-5318-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6442A67E40
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 21:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071C619C7F08
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D11F4CBE;
	Tue, 18 Mar 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shtxKuip"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484F20E719;
	Tue, 18 Mar 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331019; cv=none; b=XL7JDPUHFY+pygLtUvwSbirAYkLNasHe9RXnYMCwmtFDf0l8MJbbJ+u0lcZBt+cGAFnSeLDuZIexvVibQD82Up+fRWIyATXVi2O8+fZTt8MptPcQhSUUrMgVKSnTlULi9B0pKGMS1IjgaB0vv5KOUiiVNideFVN4HtMCbxNLHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331019; c=relaxed/simple;
	bh=mYDLqZRVkjiscfRChjiKmG8FSDBLtAmgpkIWzH4Rpbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4vZFu/NMv2/tMKsMtlDz+J92bHoT5RPSW1b/DT21KJE2L54xXit9j9k//f70HfboLcleeFGvQqsWjkgBuHo7fSRtRoLK5OJBoPQr88DgsSjRvw7BNEvuzDotECpPuhnwN6wSQ3wSPidKW1bx/iRP1Cj96rbUSN88FgMGncUVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shtxKuip; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKcXI7007925;
	Tue, 18 Mar 2025 20:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pf5N9w
	HAvSAGxcpeXoCl8WiEzJGTliGZvXNpvQynP8Q=; b=shtxKuip1BnIXOHESMPb+R
	l1oIWRBp47FdJWbDd/w0X05vEw3Lc0xQmwVxv8rWjnY+e6EFuGLUH4MZxUsxiEFd
	4vXaIPC+i3UG4ihm1YwXaTHLJ2j0okROE3Wvy70pR2j2Ltc78tvjXqHM5J68oWRH
	63lRt/6N2lYjJsfaLC/LCQBIu08Pw/9xIfeKvvUspcJ1lJ2L8V6LJjT+qQwCpuXE
	lknzABoAFzj4bHzlvY3Y6jq5aAeQPCucDUWenXX7NelQ0GYQ9Inz7LljXPURVLpy
	dBWNzjeuws72BgLzDzuWhSWqbXo5fgLNRJvJYXDCFUZraryqeWNvIVWQ6xIzN71g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yg13w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:50:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IKnxb5029907;
	Tue, 18 Mar 2025 20:49:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yg13u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:49:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJqUK0005664;
	Tue, 18 Mar 2025 20:49:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8yx3h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:49:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IKnw4e32244264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 20:49:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81FF58055;
	Tue, 18 Mar 2025 20:49:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25615804B;
	Tue, 18 Mar 2025 20:49:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 20:49:57 +0000 (GMT)
Message-ID: <4e760360258bda56fbcb8f67e865a7a4574c305a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once
 at first use
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2025 16:49:57 -0400
In-Reply-To: <87y0x2cozs.fsf@>
References: <20250313173339.3815589-1-nstange@suse.de>
	 <20250313173339.3815589-7-nstange@suse.de>
	 <34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
	 <8305c89ec354320100ec272052c036300366a2af.camel@linux.ibm.com>
	 <87y0x2cozs.fsf@>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LFQGF_C9ESzzYACCfBDjjhoSmOAl-h1e
X-Proofpoint-ORIG-GUID: HP8o7M_mJm5ljTeGy1Bu7wzYyYbIFagt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180148

On Tue, 2025-03-18 at 16:55 +0100, Nicolai Stange wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>=20
> > On Tue, 2025-03-18 at 11:26 +0100, Nicolai Stange wrote:
> > > Mimi Zohar <zohar@linux.ibm.com> writes:
> > >=20
> > > > On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
> > > > > Normally IMA would extend a template hash of each bank's associat=
ed
> > > > > algorithm into a PCR. However, if a bank's hash algorithm is unav=
ailable
> > > > > to the kernel at IMA init time, it would fallback to extending pa=
dded
> > > > > SHA1 hashes instead.
> > > > >=20
> > > > > That is, if e.g. SHA-256 was missing at IMA init, it would extend=
 padded
> > > > > SHA1 template hashes into a PCR's SHA-256 bank.
> > > > >=20
> > > > > The ima_measurement command (marked as experimental) from ima-evm=
-utils
> > > > > would accordingly try both variants when attempting to verify a m=
easurement
> > > > > list against PCRs. keylime OTOH doesn't seem to -- it expects the=
 template
> > > > > hash type to match the PCR bank algorithm. I would argue that for=
 the
> > > > > latter case, the fallback scheme could potentially cause hard to =
debug
> > > > > verification failures.
> > > > >=20
> > > > > There's another problem with the fallback scheme: right now, SHA-=
1
> > > > > availability is a hard requirement for IMA, and it would be good =
for a
> > > > > number of reasons to get rid of that. However, if SHA-1 is not av=
ailable to
> > > > > the kernel, it can hardly provide padded SHA-1 template hashes fo=
r PCR
> > > > > banks with unsupported algos.
> > > > >=20
> > > > > There are several more or less reasonable alternatives possible, =
among
> > > > > them are:
> > > > > a.) Instead of padded SHA-1, use padded/truncated ima_hash templa=
te
> > > > >     hashes.
> > > > > b.) Record every event as a violation, i.e. extend unsupported ba=
nks
> > > > >     with 0xffs.
> > > > > c.) Don't extend unsupported banks at all.
> > > > > d.) Invalidate unsupported banks only once (e.g. with 0xffs) at f=
irst
> > > > >     use.
> > > > >=20
> > > > > a.) would make verification from tools like ima_measurement nearl=
y
> > > > >     impossible, as it would have to guess or somehow determine im=
a_hash.
> > > > > b.) would still put an significant and unnecessary burden on tool=
s like
> > > > >     ima_measurement, because it would then have to exercise three
> > > > >     possible variants on the measurement list:
> > > > >     - the template hash matches the bank algorithm,
> > > > >     - the template hash is padded SHA-1,
> > > > >     - the template hash is all-ones.
> > > > > c.) is a security risk, because the bank would validate an empty
> > > > >     measurement list.
> > > > >=20
> > > > > AFAICS, d.) is the best option to proceed, as it allows for deter=
mining
> > > > > from the PCR bank value in O(1) whether the bank had been maintai=
ned by
> > > > > IMA or not and also, it would not validate any measurement list (=
except
> > > > > one with a single violation entry at the head).
> > > >=20
> > >=20
> > > Hi Mimi,
> > >=20
> > > > What a pleasure reviewing your patch set.  Nicely organized.  Well =
written patch
> > > > descriptions.
> > >=20
> > > thank you :)
> > >=20
> > > > Currently with the SHA1 hash algorithm, whether it is being extende=
d into the
> > > > TPM or not, the measurement list is complete.  Relying on the ima_h=
ash in the
> > > > current kernel and the subsequent kexec'ed kernel should be fine, a=
ssuming if
> > > > they're different hash algorithms both TPM banks are enabled.  Othe=
rwise, the
> > > > measurement lists will be incomplete.
> > >=20
> > > Yes. However with your comment I'm now realizing there's an issue if =
the
> > > set of supported hash algorithms differs between the previous and the
> > > next, kexeced kernel -- something I admittedly hadn't thought of befo=
re.
> > >=20
> > > The current behavior as implemented in this RFC is that an unsupporte=
d
> > > PCR bank would get invalidated *once* upon first use, i.e. extended o=
nce
> > > with e.g. all 0xFEs. (Note that the actual patch implements invalidat=
ion
> > > with all 0xFFs, for the choice of the exact invalidation value see
> > > below). The idea is that
> > > a.) tools could easily recognize this by comparing the PCR bank value
> > >     against constant HASH(00 .. 00 | fe ... fe)
> > > b.) and they would fail to verify any non-trivial event log against s=
uch
> > >     a PCR bank if they did not do that comparison ahead.
> > >=20
> > > In order to implement this invalidate-once logic, there's that
> > > ima_extended_pcrs_mask you asked about in reply to [3/7], the
> > > preparatory patch for [4/7] ("ima: track the set of PCRs ever
> > > extended"). As the set of PCRs ever to be found in any policy rule
> > > cannot be predicted, their unsupported banks cannot get invalidated o=
nce
> > > at __init. Hence this inalidate-at-first-extend logic, which needs th=
at
> > > tracking of PCRs ever extended as maintained in ima_extended_pcrs_mas=
k.
> > >=20
> > > Upon kexec, the current patchset attempts to restore the
> > > ima_extended_pcrs_mask from the previous kernel by walking through th=
e
> > > measurement list, setting a bit for each PCR found in any event.
> > >=20
> > > Now consider the following:
> > > - some hash algorithm is supported by the initially booted kernel,
> > > - but not in the subsequently kexeced one.
> > >=20
> > > The initially booted kernel would not invalidate the given hash
> > > algorithm's bank for any PCR, and the kexeced one would neither, beca=
use
> > > it would restore the ima_extended_pcrs_mask from the initially booted
> > > one. However, the kexeced kernel would also not extend any further
> > > events into the now unsupported PCR banks then. That means that these
> > > PCR banks would happily verify a measurement list truncated to the po=
int
> > > before the kexec, which is of course bad.
> > >=20
> > >=20
> > > I can see two ways around this:
> > > a.) Give up on the invalidate-once scheme, unconditionally invalidate
> > >     unsupported banks (with 0xfe .. fe) for every new measurement lis=
t
> > >     entry.
> > >=20
> > > b.) Make the kexeced kernel to read back PCR banks it doesn't support
> > >     from the TPM at __init and see if they had been invalidated by th=
e
> > >     previous kernel. Set the bit in ima_extended_pcrs_mask *only* if =
so.
> > >     That is, invalidate unsupported and not yet invalidated PCR banks
> > >     upon first use.
> > >=20
> > >     Also, make it read PCR banks it does support and refrain from
> > >     further extending any found to have been invalidated before (for =
all
> > >     PCRs mentioned in the measurement list). That is, leave previousl=
y
> > >     invalidated PCR banks alone.
> > >=20
> > > Going with a.) would mean that verifiers would not be able to recogni=
ze
> > > in O(1) anymore that some bank was unsupported and had not been
> > > maintained by the kernel. It would still be possible to figure in lin=
ear
> > > time whether neither of the kernels in a kexec chain covered by a sin=
gle
> > > measurement list did support a given PCR bank hash.
> > >=20
> > > For implementing b.), one would have to store a table of precomputed
> > > HASH(00 .. 00 | fe .. fe) values for every recognized hash possible i=
n
> > > .rodata for comparison purposes, i.e. for every entry in
> > > tpm2_hash_map[5] at least -- after all, the whole point is to deal wi=
th
> > > hashes for which no implementation is available to the kernel, so the=
se
> > > values cannot get computed dynamically at runtime.
> > >=20
> > > With that, if the initially booted kernel did not support some hash
> > > algorithm, it would be recognizable by verifiers in O(1) time.
> > >=20
> > > If the initially booted kernel did support a given hash, but a
> > > subsequent kernel in the kexec chain would not, the PCR would get
> > > invalidated by the latter. This sitatuation cannot be detected at all
> > > (with reasonable effort) from the final PCR hash bank value alone and
> > > verification against it would fail then. Perhaps it's noteworthy that
> > > this is true with any possible scheme, including the currently
> > > implemented one extending with padded SHA1 into unsupported banks.
> > >=20
> > >=20
> > > I think that the decision about what to do now boils down to whether
> > > there's any value in verifiers being able to tell that a PCR bank had
> > > been unsupported and not been maintained rather than to simply fail i=
ts
> > > verification if attempted.
> > >=20
> > > If it is not important, or linear time + the additional implementatio=
n
> > > complexity burden at the verifier side is acceptable, the much simple=
r
> > > a.) would do.
> > >=20
> > > Otherwise I could give implementing b.) a try and see how bad the
> > > resulting code would get.
> > >=20
> > > What do you think?
> >=20
> > Let me try to summarize 'b'.  The initial unsupported hash algorithms w=
ould
> > continue to be unsupported in subsequent kexec's.  However this does no=
t address
> > the case where the initial kernel image supported a hash algorithm, but=
 the
> > subsequent kexec'ed image does not.  The TPM bank has already been exte=
nded with
> > other values.  In this case, like the original violation the attestatio=
n service
> > would not verify.  If I'm understanding it correctly, 'b' is thus a par=
tial
> > solution.
>=20
> Yes, that all matches exactly what I was trying to say. FWIW, I might be
> way too naive, but I would expect two categories of existing verifier
> behaviors:
> - "Real" ones like keylime or so, which are being asked to verify
>   against a single specific bank and the result is either yes or no with
>   no inbetween.  In particular, these wouldn't fallback to checking
>   whether something else like padded SHA1s would perhaps verify.
> - The ones more in the development/debugging/testsuite realm, which
>   would attempt to verify against all banks and fail (the test?) if any
>   does not verify. These would try harder to avoid false negatives by
>   testing for the alternatives like padded SHA1s as well. I suppose
>   ima-evm-utils' ima_measurement would qualify as such one.
>=20
> For the first class, simply invalidating the unsupported PCR banks
> somehow, i.e. option a.), is good enough.  For the second kind however,
> the question is whether something like b.) would be helpful and the
> additional complexity on the kernel side warranted. But agreed, it's a
> partial and best-effort solution. If one kexecs into a kernel with a
> proper subset of supported TPM bank hashes, it wouldnt't work.

Refer to comment on "Replacing the "Kconfig select".

>=20
> > My concern with 'b' is the ability to read the multiple TPM bank PCRs s=
o early
> > during kernel initialization.  Will it succeed?  If it does succeed, wi=
ll it
> > introduce initialization delays?
>=20
> As the boot aggregate gets extended already at that point in time
> (IIRC), I'd expect that reading the PCRs would probably succeed as
> well. For the delays imposed on the kexec restore path -- I can't tell
> unfortunately. But I would only do it on kexec restore if the
> measurement list is non-empty anyway, so systems not having IMA enabled
> or ones which wouldn't kexec are not affected.

Ok
>=20
>=20
> > FYI, because the IMA Kconfig selects SHA1, we're guaranteed that SHA1 e=
xists in
> > the kernel and the subsequent kexec'ed kernel.  For this reason we're g=
uaranteed
> > that the measurement list is complete.  The simplest solution, not nece=
ssarily
> > the best, would be to punt the problem for the time being by replacing =
the
> > "select" with a different hash algorithm.
>=20
> Yes, that would work as well. IIUC, it would mean that we would
> e.g. extend truncated SHA-256 template hashes into a SHA-1 bank, right?
> However, since no existing tool like 'ima_measurement' is expecting
> that, and would fail a verification then, I'm currently struggling to
> see the advantage over just doing a.) and invalidating the PCR banks
> with a fixed value right away?

Replacing the "Kconfig select" has more to do with having at least one
guaranteed complete measurement list.  I'm fine with extending a TPM bank w=
ith
an unknown kernel hash algorithm violation (either option a or b).

>=20
> > > > This patch set introduces a new definition of integrity violation. =
Previously it
> > > > was limited to open-writers and ToMToU integrity violations.  Now i=
t could also
> > > > mean no kernel hash algorithm available.  Unfortunately some attest=
ation
> > > > services simply ignore integrity violations.
> > >=20
> > > Yeah, there's indeed an ambiguity. I think the right thing to do is t=
o
> > > make measurement lists unverifiable against unsupported banks and wou=
ld
> > > propose to use 0xfe ... fe for the associated invalidations instead o=
f
> > > the 0xff .. ff used for violation events already.
> >=20
> > I just realized that unlike the existing open-writers/ToMToU violations=
, by
> > definition the new unsupported bank violation would not be included in =
the
> > measurement list, but just extended into the TPM.
>=20
> That's true, but when invalidating unsupported banks with a single ff
> ... ff, one could successfully verify a measurement list having only a
> single violation entry against an invalidated bank AFAICS. I think it
> would be more robust to use a different constant for the invalidation.

Agreed.

thanks,

Mimi

>=20
>=20
> > > > > So implement d.). As it potentially breaks existing userspace, i.=
e.
> > > > > the current implementation of ima_measurement, put it behind a Kc=
onfig
> > > > > option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the orig=
inal
> > > > > behavior of extending with padded SHA-1 is retained. Otherwise th=
e new
> > > > > scheme to invalidate unsupported PCR banks once upon their first =
extension
> > > > > from IMA is implemented instead. As ima_measurement is marked as
> > > > > experimental and I find it unlikely that other existing tools dep=
end on
> > > > > the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TP=
M_EXTEND
> > > > > Kconfig option default to "n".
> > > > >=20
> > > > > For IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn,
> > > > > - make ima_calc_field_array_hash() to fill the digests correspond=
ing to
> > > > >   banks with unsupported hash algorithms with 0xffs,
> > > > > - make ima_pcr_extend() to extend these into the unsupported PCR =
banks only
> > > > >   upon the PCR's first usage, skip them on subsequent updates and
> > > > > - let ima_init_ima_crypto() help it with that by populating the n=
ew
> > > > >   ima_unsupported_tpm_banks_mask with one bit set for each bank w=
ith
> > > > >   an unavailable hash algorithm at init.
> > > > >=20
> > > > > [1] https://github.com/linux-integrity/ima-evm-utils
> > > > >=20
> > > > > Signed-off-by: Nicolai Stange <nstange@suse.de>
> > > > > ---
> > >=20
> >=20
>=20


