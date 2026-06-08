Return-Path: <linux-integrity+bounces-9775-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EAh0ONzwJmoToAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9775-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 18:42:04 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A8658D42
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 18:42:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9775-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9775-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EDC63071FCC
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F138BF9A;
	Mon,  8 Jun 2026 16:23:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446337C10A;
	Mon,  8 Jun 2026 16:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935802; cv=none; b=mkYLdi4u4r1BVDuJjYEvQ9Ge2kcLAT6t0IxNO8IxDBE3g5D9Ly00IISJmOhYCMZdjF95ImttfiPoagkIfVYid7NomFycanC5Gbx7YHY/5Z3yGNwcfu0Ftx2ReCZbCeH49cPeiJAMRZGdUi3WdNIdvlI/N/XhNOCBfASid+8NOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935802; c=relaxed/simple;
	bh=UtJgtwgXfwps+s5sNmF1cfHJzyuekBijtL+cgdHbWS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXN6/ymXdyu/s0K0rHkBi2Dz7z+/WD1q+3Z469+dn34C94UdkP6FaoRBpAApuNdOdAGUy1j7KIZJYvpsuGAagcqHA3YGBtUIDHE+MvM3ZE07jGTn8VawePDibYupael7VCN/4tpLWPulEsa5rW3hnuXQvTXhMEeqTMre0nUz2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYxz03Pnrz1HChG;
	Tue,  9 Jun 2026 00:17:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2F1554056C;
	Tue,  9 Jun 2026 00:23:11 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnt41k7CZq3ACTAA--.56391S2;
	Mon, 08 Jun 2026 17:23:10 +0100 (CET)
Message-ID: <96b1b56987e0d0272027d0e207c779157058a344.camel@huaweicloud.com>
Subject: Re: [PATCH v7 00/12] ima: Exporting and deleting IMA measurement
 records from kernel memory
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 skhan@linuxfoundation.org,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 08 Jun 2026 18:22:59 +0200
In-Reply-To: <22debae414a07a3cbdb62e723dfb737d6d4bd693.camel@linux.ibm.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
	 <22debae414a07a3cbdb62e723dfb737d6d4bd693.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnt41k7CZq3ACTAA--.56391S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4kAF1kAFW3Jw4xGF4fuFg_yoW7Xryrpa
	9aqayIk395J34rAw1xtw48Jw4Fv3yfKa1DGrn5Jw1xAF1DWFyvvr4YkrWY9F9Igr10vryj
	vw42qrW5ua1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoY
	FADUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGomL7gSHwABsD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	TAGGED_FROM(0.00)[bounces-9775-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E4A8658D42

On Mon, 2026-06-08 at 12:21 -0400, Mimi Zohar wrote:
> On Fri, 2026-06-05 at 19:22 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > The IMA measurements list is currently stored in the kernel memory.
> > Memory occupation grows linearly with the number of records, and can
> > become a problem especially in environments with reduced resources.
> >=20
> > While there is an advantage in keeping the IMA measurements list in
> > kernel memory, so that it is always available for reading from the
> > securityfs interfaces, storing it elsewhere would make it possible to
> > free precious memory for other kernel usage.
> >=20
> > The IMA measurements list needs to be retained and safely stored for ne=
w
> > attestation servers to validate it. Assuming the IMA measurements list
> > is properly saved, storing it outside the kernel does not introduce
> > security issues, since its integrity is anyway protected by the TPM.
> >=20
> > Hence, the new IMA staging mechanism is introduced to export IMA
> > measurements to user space and delete them from kernel space.
> >=20
> > Staging consists in atomically moving the current measurements list to =
a
> > temporary list, so that measurements can be deleted afterwards. The
> > staging operation locks the hot path (racing with addition of new
> > measurements) for a very short time, only for swapping the list
> > pointers. Deletion of the measurements instead is done locklessly, away
> > from the hot path.
> >=20
> > There are two flavors of the staging mechanism. In the staging with
> > prompt, all current measurements are staged, read and deleted upon
> > confirmation. In the staging and deleting flavor, N measurements are
> > staged from the beginning of the current measurements list and
> > immediately deleted without confirmation.
> >=20
> >=20
> > Usage
> > =3D=3D=3D=3D=3D
> >=20
> > The IMA staging mechanism can be enabled from the kernel configuration
> > with the CONFIG_IMA_STAGING option. This option prevents inadvertently
> > removing the IMA measurement list on systems which do not properly save
> > it.
> >=20
> > If the option is enabled, IMA duplicates the current securityfs
> > measurements interfaces (both binary and ASCII), by adding the _staged
> > file suffix. Both the original and the staging interfaces gain the writ=
e
> > permission for the root user and group, but require the process to have
> > CAP_SYS_ADMIN set.
> >=20
> > The staging mechanism supports two flavors.
> >=20
> > Staging with prompt
> > ~~~~~~~~~~~~~~~~~~~
> >=20
> > The current measurement list is moved to a temporary staging area,
> > allowing it to be saved to external storage, before being deleted upon
> > confirmation.
> >=20
> > This staging process is achieved with the following steps.
> >=20
> >   1.  echo A > <_staged interface>: the user requests IMA to stage the
> >       entire measurements list;
> >   2.  cat <_staged interface>: the user reads the staged measurements;
> >   3.  echo D > <_staged interface>: the user requests IMA to delete
> >       staged measurements.
> >=20
> > Staging and deleting
> > ~~~~~~~~~~~~~~~~~~~~
> >=20
> > N measurements are staged to a temporary staging area, and immediately
> > deleted without further confirmation.
> >=20
> > This staging process is achieved with the following steps.
> >=20
> >   1.  cat <original interface>: the user reads the current measurements
> >       list and determines what the value N for staging should be;
> >   2.  echo N > <original interface>: the user requests IMA to delete N
> >       measurements from the current measurements list.
> >=20
> >=20
> > Management of Staged Measurements
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Since with the staging mechanism measurement records are removed from
> > the kernel, the staged measurements need to be saved in a storage and
> > concatenated together, so that they can be presented during remote
> > attestation as if staging was never done. This task can be accomplished
> > by a remote attestation agent modified to support staging, or a system
> > service.
> >=20
> >=20
> > Patch set content
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Patches 1-8 are preparatory patches to quickly replace the hash table,
> > maintain separate counters for the different measurements list types,
> > mediate access to the measurements list interface, and simplify the sta=
ging
> > patches.
> >=20
> > Patch 9 introduces the staging with prompt flavor. Patch 10 makes it
> > possible to flush the hash table when deleting all the staged measureme=
nts.
> > Patch 11 introduces the staging and deleting flavor. Patch 12 adds the
> > documentation of the staging mechanism.
> >=20
> >=20
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > v6:
> >  - Make ima_extend_list_mutex as static since it is not needed anymore =
by
> >    ima_dump_measurement_list() (suggested by Mimi)
> >  - Export ima_flush_htable in patch 11 instead of 10 (suggested by Mimi=
)
> >  - Add clarification in the documentation regarding a proactive remote
> >    attestation agent, and storing all the measurements in the storage
> >    (suggested by Mimi)
>=20
> Roberto, thank you for making these and all the other changes.  The patch=
 set is
> now queued in next-integrity.

Perfect, thank you!

Roberto


