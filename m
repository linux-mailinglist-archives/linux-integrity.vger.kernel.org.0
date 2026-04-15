Return-Path: <linux-integrity+bounces-9187-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI9IGt7y3mmIMwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9187-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:07:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142A3FFAF3
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB83A302AF37
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0D2D9ECB;
	Wed, 15 Apr 2026 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g6XeLZBh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D162C859
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218835; cv=none; b=TWbj7RJPMEjKUMyX/QO8F4P1cfsc4gbX3gf+kjZu7c1Q5xde5LEA0Sxxx+PPuSb+Xw5+0znLxLxGiv+UsFFlq76CDlgN5SiMkwd2/h4pERah5DTHHeGt4vO75TLsIvIJ7vspIjjedRc+nJQAEWN+6sWQ+17iZo9xRkiZpcctxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218835; c=relaxed/simple;
	bh=Es8fpT9bu7EESDkMBpRrdAZkVl3a7Gb9E0o7DUx2oyI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ak0KeUs6xzCqtVkQE6zDe3amJiq9JxFq9cbSYvYtXboa0zHujxbUTyZObV6FejHrcwFRaujsOCUjNEZ/bMeGa9wgeECserOSnG5R1wKjDPLsT8DGvrppqLcRIZtBAg9sdcKGo/Lqdl737q6SDBg/UCzdtMV8BBejTpDKTF5iMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g6XeLZBh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ELaPkI1832986;
	Wed, 15 Apr 2026 02:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CSs2sv
	jc1dOM10HwOVD++VQa7bhMhE3lXd68lxrii3k=; b=g6XeLZBhHZiavd41Sjltcc
	Qx6VHXx+4+BX5E8/P8iSliav1lUWJSxskJbqMlrpc1o7Uaiiv5D796y00OaiooN4
	hg6XgXpT6P7zN9Aa9RSLz4yn4hw8oHkkL2/yS29UdJv0gNi4Zsi9WEJuQvmaweoe
	iwVqnhLtWutC40OJQiLlgTLBfFOetiR6pG3Pvu+i0ikK9zjU76l7e3Mr6t4WRTvK
	UbousAj8JLU+3fBczHx29yQFhcAFlMZ4I/arZyTLIYi5zKYPc/3Eh0MC0J2GmKj7
	/IQdNvoQi56nwkH6Xj3M8xtjcJ6/YLI72CvUjveZ6gWSd8+Xny//uAY20pA5T4tQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rdwha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:07:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63ELkx5e003586;
	Wed, 15 Apr 2026 02:07:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mncasm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:07:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F270g316188112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 02:07:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69EA958066;
	Wed, 15 Apr 2026 02:07:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F045805C;
	Wed, 15 Apr 2026 02:06:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.163.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 02:06:59 +0000 (GMT)
Message-ID: <28cc90640be7efadb40fdd0af699e3a69b632d83.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 00/10] Fix dm-ima bugs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Mike Snitzer <snitzer@kernel.org>,
        Benjamin Marzinski
 <bmarzins@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        steven chen	 <chenste@linux.microsoft.com>
In-Reply-To: <ad51kuxJuU84Amep@kernel.org>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
	 <ad51kuxJuU84Amep@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:06:59 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAxNSBTYWx0ZWRfX2ZDh/t/AGpgl
 6Vg9NdvyaceolBI6iHj+6tSM240x6p2WlrrGe5xtO6ejqJgVTRioZbQIeJTijsPypR4NdN8J1Az
 XSd4RIMJr6cOzILRckLFzpw3zXZBgIrnWJzMQw27t8Qr8tlMu3OM9hKaSp4rWLZn0gmz/e6cJ2s
 hvp+tylzwiDWB1Izqe+pJ4C9qgwLgyA4fgMr2Rke0/pYncbNDG1B9PApXX2pAfGH3IZqTjlAQEV
 8f336kn2ki2EO8+8koUNwRyVn/N6QB+nwRc25zrCx6845vbXAR/ZMqr3ZJXS6vX1sURCOB4ydtO
 7N/Otjzia2rRhxgLiTq7vO9MHBBnbFVtwqb2/0ma43D7i1124crt8Yj+ewzifpiDnNjVmHl6e1t
 kb3+ZQeZUN3QimOpKyw451pLF5ivwnKv9Eneqo8gidGAWouplzbw9TETcU1HO2+YwMIXhGEqb8p
 11ueUeYAZzB3G4IZZ3g==
X-Proofpoint-ORIG-GUID: eqKrFqGF0yWS8JOIsq5kY4W8_hVLNdbh
X-Proofpoint-GUID: oD_7GsmHchX54z0PdWmFeKOUWitPLLnk
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69def2c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=6cIjQJOKbT__1nPyWC8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150015
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lists.linux.dev,vger.kernel.org,huawei.com,gmail.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-9187-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2142A3FFAF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Cc: Lakshmi Ramasubramanian, steven chen]

On Tue, 2026-04-14 at 13:12 -0400, Mike Snitzer wrote:
> On Mon, Apr 13, 2026 at 08:22:34PM -0400, Benjamin Marzinski wrote:
> > The dm-ima code does not guarantee that the dm_ima_measure_on_*
> > functions will not be called at the same time. Since they modify and
> > free shared memory, this can lead to Use-After-Free errors or garbage
> > measurements. Further, they don't make sure that the state they measure
> > corresponds to the actual device state. For instance if table_load()
> > runs at the same time as do_resume() on a table swap,
> > dm_ima_measure_on_device_resume() can end up thinking the wrong table i=
s
> > active. Or a concurrent dm_hash_rename() and a table swap, can end up
> > with a the new active table still using the old name. This patchset
> > makes sure the the dm-ima function are serialized and report the correc=
t
> > device state.
> >=20
> > However, the code is still messier that in could be. This is because
> > it duplicates the current measurement events and format. I would really
> > like to know if that is necessary. Specifically, it currently measures
> > the following dm device and table actions:
> >=20
> > load
> > clear
> > rename
> > resume
> > remove
> >=20
> > I don't see the benefit of reporting changes to the inactive table, or
> > resumes where the device does not change state. From the user's point o=
f
> > view, the device is still the same after these events.  At the same
> > time, it doesn't measure device creates if no table was loaded, so you
> > can have situations where the the first measurement for a device is a
> > rename or a remove. A more sensible set of actions to measure would be:
> >=20
> > create
> > table_swap
> > rename
> > remove
> >=20
> > Also, the measurement format doesn't map well to how dm device's are
> > actually set up, in a way that makes it harder for the code and records
> > extraneous information. First, like I mentioned before, I don't see the
> > benefit of measuring the inactive table. Second, the name, uuid, and
> > major/minor numbers are properties of the device, not it's table (and d=
m
> > devices can't have partitions, so the minor count will always be 1). I
> > don't see a reason to store and occasinally log this information twice,
> > if there is an active and incative table, and it forces extra
> > coordination between the dm_ima_measure_on_* functions.
> >=20
> > I'm wondering it we are stuck with the current events and format, now
> > that this has been released? Or could we bump the version, and change
> > what events we measure, and how we format the output?
> >=20
> > Benjamin Marzinski (10):
> >   dm-ima: remove dm_ima_reset_data()
> >   dm-ima: remove broken last_target_measured logic
> >   dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
> >   dm-ima: don't copy the active table to the inactive table
> >   dm-ima: Fix UAF errors and measuring incorrect context
> >   dm-ima: remove new_map from dm_ima_measure_on_device_clear
> >   dm-ima: Fix issues with dm_ima_measure_on_device_rename
> >   dm-ima: Handle race between rename and table swap
> >   dm-ima: Fail more gracefully in dm_ima_measure_on_*
> >   dm-ima: use active table's size if available
> >=20
> >  drivers/md/dm-ima.c   | 506 +++++++++++++++++++-----------------------
> >  drivers/md/dm-ima.h   |  67 ++++--
> >  drivers/md/dm-ioctl.c | 146 +++++++++++-
> >  drivers/md/dm.c       |   2 +-
> >  4 files changed, 421 insertions(+), 300 deletions(-)
>=20
> Pretty extensive changes needed here all things considered.
>=20
> SO I'm aware, who is using dm-ima?  I see that Tushar Sugandhi is no
> longer at Microsoft and so he isn't cc'd on these changes.  I can
> infer from Cc some potential users, but I just want to make sure this
> code isn't just technical debt that we're having to carry in DM now?
>=20
> Thanks,
> Mike

