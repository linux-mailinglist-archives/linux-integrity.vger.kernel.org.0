Return-Path: <linux-integrity+bounces-5313-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5535A67670
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8FC16EA15
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7F2080EF;
	Tue, 18 Mar 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UEebFxLY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D19189902;
	Tue, 18 Mar 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308345; cv=none; b=SBFJhIHXZFL7pAUK21bFqpzzYVbX7JsBvQ+TSbxSVoV4EwAQCK3fjlLKLr8Zpgp6Medj8l45Xs8SmD17K1c7OPGgxSgw9B6c088XRcijQEvtoyFBjMZTiyIztc4QzmZe4aymfaZR83uaQ4ssvCEtHV+TAlAdA24HJgX0nPIYx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308345; c=relaxed/simple;
	bh=12W50GQ9qY6CkaCodCzV9iWdcTwmT1qtDQvZmLvopv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eO5Cx1UgYTv3KWMasi9m1HT1/XqbkAvqkQylpaspa8Puo+CuYkQzTggY+q3M4trVJnMA446cdUPzPKUMiUbw6KcNKYr4URrpc1HksKlNU4t8Yri+1dNOLd3pCrdk5PVLFcZj/ul9vrHEnSDJYFQRi3NN3RlAOZJJhljqUxftYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UEebFxLY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9cXhB002794;
	Tue, 18 Mar 2025 14:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=alI2yU
	twUzorjqprmTXI5WwI9SgFcg6nUrz8s/lpU/M=; b=UEebFxLYILKerue3kg2K0g
	X2s9omBmiZ1rozT5UGby0pSDeeOCCoctwnhWM8X2bS0wHIm2cER7nNl6nI7YvKkM
	rezojPVA3IdHDYV+atWO2MJ9sXBFdKPTdpGM9gdO7KL5TpE219xLDwTV5qiaCd/O
	WbQn3eBZF1MSPkj8fxePE/UaAKHLw/3Em+z/+bTYal+Od0xwBIvml5cGvqJDpOlW
	Ydky+dZ99+BsV3psIfooKeuvUvAHZQFEFZ50R1mekqleEz50M0EGRhZKCDvbGCnH
	u5IYA8P43CU7rZnVPcy/yELgZ/cNvMFRSpYx+5T8bT62UOFbkHTM2o0HufjRKfkw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0m9cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:32:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IE1ptT019072;
	Tue, 18 Mar 2025 14:32:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0m9cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:32:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICU7FJ005734;
	Tue, 18 Mar 2025 14:32:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2bwn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:32:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IEW8Qc33358476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 14:32:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C355803F;
	Tue, 18 Mar 2025 14:32:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D8958056;
	Tue, 18 Mar 2025 14:32:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.180.96])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 14:32:07 +0000 (GMT)
Message-ID: <8305c89ec354320100ec272052c036300366a2af.camel@linux.ibm.com>
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
Date: Tue, 18 Mar 2025 10:32:07 -0400
In-Reply-To: <87zfhik52e.fsf@>
References: <20250313173339.3815589-1-nstange@suse.de>
	 <20250313173339.3815589-7-nstange@suse.de>
	 <34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
	 <87zfhik52e.fsf@>
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
X-Proofpoint-GUID: EMEnUF8QNYtn7zPvX3gz3-ucevc0iUbF
X-Proofpoint-ORIG-GUID: XabSEXPN3xRXSPIDnbotfA3eoj6eFnyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180107

On Tue, 2025-03-18 at 11:26 +0100, Nicolai Stange wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>=20
> > On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
> > > Normally IMA would extend a template hash of each bank's associated
> > > algorithm into a PCR. However, if a bank's hash algorithm is unavaila=
ble
> > > to the kernel at IMA init time, it would fallback to extending padded
> > > SHA1 hashes instead.
> > >=20
> > > That is, if e.g. SHA-256 was missing at IMA init, it would extend pad=
ded
> > > SHA1 template hashes into a PCR's SHA-256 bank.
> > >=20
> > > The ima_measurement command (marked as experimental) from ima-evm-uti=
ls
> > > would accordingly try both variants when attempting to verify a measu=
rement
> > > list against PCRs. keylime OTOH doesn't seem to -- it expects the tem=
plate
> > > hash type to match the PCR bank algorithm. I would argue that for the
> > > latter case, the fallback scheme could potentially cause hard to debu=
g
> > > verification failures.
> > >=20
> > > There's another problem with the fallback scheme: right now, SHA-1
> > > availability is a hard requirement for IMA, and it would be good for =
a
> > > number of reasons to get rid of that. However, if SHA-1 is not availa=
ble to
> > > the kernel, it can hardly provide padded SHA-1 template hashes for PC=
R
> > > banks with unsupported algos.
> > >=20
> > > There are several more or less reasonable alternatives possible, amon=
g
> > > them are:
> > > a.) Instead of padded SHA-1, use padded/truncated ima_hash template
> > >     hashes.
> > > b.) Record every event as a violation, i.e. extend unsupported banks
> > >     with 0xffs.
> > > c.) Don't extend unsupported banks at all.
> > > d.) Invalidate unsupported banks only once (e.g. with 0xffs) at first
> > >     use.
> > >=20
> > > a.) would make verification from tools like ima_measurement nearly
> > >     impossible, as it would have to guess or somehow determine ima_ha=
sh.
> > > b.) would still put an significant and unnecessary burden on tools li=
ke
> > >     ima_measurement, because it would then have to exercise three
> > >     possible variants on the measurement list:
> > >     - the template hash matches the bank algorithm,
> > >     - the template hash is padded SHA-1,
> > >     - the template hash is all-ones.
> > > c.) is a security risk, because the bank would validate an empty
> > >     measurement list.
> > >=20
> > > AFAICS, d.) is the best option to proceed, as it allows for determini=
ng
> > > from the PCR bank value in O(1) whether the bank had been maintained =
by
> > > IMA or not and also, it would not validate any measurement list (exce=
pt
> > > one with a single violation entry at the head).
> >=20
>=20
> Hi Mimi,
>=20
> > What a pleasure reviewing your patch set.  Nicely organized.  Well writ=
ten patch
> > descriptions.
>=20
> thank you :)
>=20
> > Currently with the SHA1 hash algorithm, whether it is being extended in=
to the
> > TPM or not, the measurement list is complete.  Relying on the ima_hash =
in the
> > current kernel and the subsequent kexec'ed kernel should be fine, assum=
ing if
> > they're different hash algorithms both TPM banks are enabled.  Otherwis=
e, the
> > measurement lists will be incomplete.
>=20
> Yes. However with your comment I'm now realizing there's an issue if the
> set of supported hash algorithms differs between the previous and the
> next, kexeced kernel -- something I admittedly hadn't thought of before.
>=20
> The current behavior as implemented in this RFC is that an unsupported
> PCR bank would get invalidated *once* upon first use, i.e. extended once
> with e.g. all 0xFEs. (Note that the actual patch implements invalidation
> with all 0xFFs, for the choice of the exact invalidation value see
> below). The idea is that
> a.) tools could easily recognize this by comparing the PCR bank value
>     against constant HASH(00 .. 00 | fe ... fe)
> b.) and they would fail to verify any non-trivial event log against such
>     a PCR bank if they did not do that comparison ahead.
>=20
> In order to implement this invalidate-once logic, there's that
> ima_extended_pcrs_mask you asked about in reply to [3/7], the
> preparatory patch for [4/7] ("ima: track the set of PCRs ever
> extended"). As the set of PCRs ever to be found in any policy rule
> cannot be predicted, their unsupported banks cannot get invalidated once
> at __init. Hence this inalidate-at-first-extend logic, which needs that
> tracking of PCRs ever extended as maintained in ima_extended_pcrs_mask.
>=20
> Upon kexec, the current patchset attempts to restore the
> ima_extended_pcrs_mask from the previous kernel by walking through the
> measurement list, setting a bit for each PCR found in any event.
>=20
> Now consider the following:
> - some hash algorithm is supported by the initially booted kernel,
> - but not in the subsequently kexeced one.
>=20
> The initially booted kernel would not invalidate the given hash
> algorithm's bank for any PCR, and the kexeced one would neither, because
> it would restore the ima_extended_pcrs_mask from the initially booted
> one. However, the kexeced kernel would also not extend any further
> events into the now unsupported PCR banks then. That means that these
> PCR banks would happily verify a measurement list truncated to the point
> before the kexec, which is of course bad.
>=20
>=20
> I can see two ways around this:
> a.) Give up on the invalidate-once scheme, unconditionally invalidate
>     unsupported banks (with 0xfe .. fe) for every new measurement list
>     entry.
>=20
> b.) Make the kexeced kernel to read back PCR banks it doesn't support
>     from the TPM at __init and see if they had been invalidated by the
>     previous kernel. Set the bit in ima_extended_pcrs_mask *only* if so.
>     That is, invalidate unsupported and not yet invalidated PCR banks
>     upon first use.
>=20
>     Also, make it read PCR banks it does support and refrain from
>     further extending any found to have been invalidated before (for all
>     PCRs mentioned in the measurement list). That is, leave previously
>     invalidated PCR banks alone.
>=20
> Going with a.) would mean that verifiers would not be able to recognize
> in O(1) anymore that some bank was unsupported and had not been
> maintained by the kernel. It would still be possible to figure in linear
> time whether neither of the kernels in a kexec chain covered by a single
> measurement list did support a given PCR bank hash.
>=20
> For implementing b.), one would have to store a table of precomputed
> HASH(00 .. 00 | fe .. fe) values for every recognized hash possible in
> .rodata for comparison purposes, i.e. for every entry in
> tpm2_hash_map[5] at least -- after all, the whole point is to deal with
> hashes for which no implementation is available to the kernel, so these
> values cannot get computed dynamically at runtime.
>=20
> With that, if the initially booted kernel did not support some hash
> algorithm, it would be recognizable by verifiers in O(1) time.
>=20
> If the initially booted kernel did support a given hash, but a
> subsequent kernel in the kexec chain would not, the PCR would get
> invalidated by the latter. This sitatuation cannot be detected at all
> (with reasonable effort) from the final PCR hash bank value alone and
> verification against it would fail then. Perhaps it's noteworthy that
> this is true with any possible scheme, including the currently
> implemented one extending with padded SHA1 into unsupported banks.
>=20
>=20
> I think that the decision about what to do now boils down to whether
> there's any value in verifiers being able to tell that a PCR bank had
> been unsupported and not been maintained rather than to simply fail its
> verification if attempted.
>=20
> If it is not important, or linear time + the additional implementation
> complexity burden at the verifier side is acceptable, the much simpler
> a.) would do.
>=20
> Otherwise I could give implementing b.) a try and see how bad the
> resulting code would get.
>=20
> What do you think?

Let me try to summarize 'b'.  The initial unsupported hash algorithms would
continue to be unsupported in subsequent kexec's.  However this does not ad=
dress
the case where the initial kernel image supported a hash algorithm, but the
subsequent kexec'ed image does not.  The TPM bank has already been extended=
 with
other values.  In this case, like the original violation the attestation se=
rvice
would not verify.  If I'm understanding it correctly, 'b' is thus a partial
solution.

My concern with 'b' is the ability to read the multiple TPM bank PCRs so ea=
rly
during kernel initialization.  Will it succeed?  If it does succeed, will i=
t
introduce initialization delays?

FYI, because the IMA Kconfig selects SHA1, we're guaranteed that SHA1 exist=
s in
the kernel and the subsequent kexec'ed kernel.  For this reason we're guara=
nteed
that the measurement list is complete.  The simplest solution, not necessar=
ily
the best, would be to punt the problem for the time being by replacing the
"select" with a different hash algorithm.

>=20
>=20
> > This patch set introduces a new definition of integrity violation. Prev=
iously it
> > was limited to open-writers and ToMToU integrity violations.  Now it co=
uld also
> > mean no kernel hash algorithm available.  Unfortunately some attestatio=
n
> > services simply ignore integrity violations.
>=20
> Yeah, there's indeed an ambiguity. I think the right thing to do is to
> make measurement lists unverifiable against unsupported banks and would
> propose to use 0xfe ... fe for the associated invalidations instead of
> the 0xff .. ff used for violation events already.

I just realized that unlike the existing open-writers/ToMToU violations, by
definition the new unsupported bank violation would not be included in the
measurement list, but just extended into the TPM.

Mimi

>=20
> > >=20
> > > So implement d.). As it potentially breaks existing userspace, i.e.
> > > the current implementation of ima_measurement, put it behind a Kconfi=
g
> > > option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original
> > > behavior of extending with padded SHA-1 is retained. Otherwise the ne=
w
> > > scheme to invalidate unsupported PCR banks once upon their first exte=
nsion
> > > from IMA is implemented instead. As ima_measurement is marked as
> > > experimental and I find it unlikely that other existing tools depend =
on
> > > the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TPM_EX=
TEND
> > > Kconfig option default to "n".
> > >=20
> > > For IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn,
> > > - make ima_calc_field_array_hash() to fill the digests corresponding =
to
> > >   banks with unsupported hash algorithms with 0xffs,
> > > - make ima_pcr_extend() to extend these into the unsupported PCR bank=
s only
> > >   upon the PCR's first usage, skip them on subsequent updates and
> > > - let ima_init_ima_crypto() help it with that by populating the new
> > >   ima_unsupported_tpm_banks_mask with one bit set for each bank with
> > >   an unavailable hash algorithm at init.
> > >=20
> > > [1] https://github.com/linux-integrity/ima-evm-utils
> > >=20
> > > Signed-off-by: Nicolai Stange <nstange@suse.de>
> > > ---
>=20


