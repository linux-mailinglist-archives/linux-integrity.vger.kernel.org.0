Return-Path: <linux-integrity+bounces-6297-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A9AC0A5D
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 13:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055754E1D46
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371128982B;
	Thu, 22 May 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZLtHkmLc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91E238C3D;
	Thu, 22 May 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912372; cv=none; b=mqnZjPNd7BBLMPkncNKdFspfq8dcgR2AHcRh5m51ELpEfXObRJrqM7Ru6Z9vK2jMu2tTxSyfbM190Q8RB7lXgTEsVmbRCroxxCOK4HnwH1viO2cSQxynyonpnp6K+E8ieSdnw4yjiI1rPY6vFWJUMhQ+Z4x1LePHhyWPUJDTAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912372; c=relaxed/simple;
	bh=t23o9My5MPTo2kL39zqs5RrxOPSJJzuwpTXXq6P5B3U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nlUNtYgDFukdRNR1ysJ85Iu9S/aEL2XlWZ4a+hBhpythTx+rMBBEvoOlDNCBFEwuf/Dd12v+XXYqkJWESlnVBRue9cY98QnmtqB9Ech8Kbi0GwxwVOSxXRhjySJRmlRUxJlO7MNnSrrFR9fZSf0kyVY5xb3xkpqrzvLDtH2oHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZLtHkmLc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M78ku1004484;
	Thu, 22 May 2025 11:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G1RQsE
	kqmML1TEPWctfGHJ1nO+XyWcWYCQfZVbO4SGM=; b=ZLtHkmLcttBfArE5upuGID
	SasonDQWYyjGKjVCmhaCrdYrHUztububtvWhbs/jtQiMCVMqIneOfnjqMIvuAM8h
	JOV16Bl4+qd5u7p4ZnOL+q2+sl0BD5t15GaEZEPFu7g58n7HSnM3xUiRf4xZGLtM
	VAx269oLzm7/iq3oR/aRYirUxFb1P19BIZdN7gtS8YeVBo0JwOEP/SYAWdyZ9CdA
	19QFTjs9jhRD1h3HNGagtOi2hDG3LVMPk3Wei720KtYwUe3kNqVelhT9gLJE7ZMj
	z0LM7+1Qi18kjlAReDfh12MDfi9W/uyfgDwx6FBTpQeQuSXt4rc3aN4hBRz4nUiw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46smh73pwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 11:12:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9jFCZ015487;
	Thu, 22 May 2025 11:12:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnh53j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 11:12:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54MBCd8b19071588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 11:12:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D0A65805C;
	Thu, 22 May 2025 11:12:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1CD5805A;
	Thu, 22 May 2025 11:12:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.163.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 May 2025 11:12:38 +0000 (GMT)
Message-ID: <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, coxu@redhat.com,
        ruyang@redhat.com, chenste@linux.microsoft.com
In-Reply-To: <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
	 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
	 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 May 2025 07:08:04 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDExMiBTYWx0ZWRfX1LqELZKjPPld HxM4ReRgZMzP/pNJFiISQK2KZE6XeEutYqzePla8pZmoBBCiQsRANn8XinzprUg2hKwNQYRS0qe sowGxT73OfTVd2GO5CfGnNIECxXELysSAoFt8PZMIQ56J7/VoKWD3P2PzZocP/S65Y1qnu76HdY
 3cZSY0JVXgEFaWlteUEuDuSquOuZzjLtDiUMZ19Z4m64JDxhinypZEG2HWSvDOkByWuDm+CnxRT XxRLjWENHA3v194fHePnML1zZ4CvwsFoBBEIwYLLi0pe1jCs8FWWX7g8IYMSaXw90DiWczLsOzC NdhXN3EoTJ4/LAawBZvhNOVo/235YWBwKPSnCSOB+DpKVqRNlE21dSRgtXVm2KbC4E0kHg3lmbM
 Qy2Mcf0wYMBlA28IDTWa/R00tcESGhFTDA2/Pfj6w5wKm8dUQjblyI/yj1WVa5bBg/v9e8mA
X-Proofpoint-GUID: 7epxmsGcW0Unb2QLmiQgzdBfzhuQoTyA
X-Proofpoint-ORIG-GUID: 7epxmsGcW0Unb2QLmiQgzdBfzhuQoTyA
X-Authority-Analysis: v=2.4 cv=EdfIQOmC c=1 sm=1 tr=0 ts=682f06a8 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=dagHe2M521LXfLvkCjsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220112

On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > CC kexec list.
> > >=20
> > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > Kdump kernel doesn't need IMA functionality, and enabling IMA will =
cost
> > > > extra memory. It would be very helpful to allow IMA to be disabled =
for
> > > > kdump kernel.
>=20
> Thanks a lot for careufl reviewing and great suggestions.
>=20
> >=20
> > The real question is not whether kdump needs "IMA", but whether not ena=
bling
> > IMA in the kdump kernel could be abused.=C2=A0 The comments below don't=
 address
> > that question but limit/emphasize, as much as possible, turning IMA off=
 is
> > limited to the kdump kernel.
>=20
> Are you suggesting removing below paragraph from patch log because they
> are redundant? I can remove it in v2 if yes.

"The comments below" was referring to my comments on the patch, not the nex=
t
paragraph.  "don't address that question" refers to whether the kdump kerne=
l
could be abused.

We're trying to close integrity gaps, not add new ones.  Verifying the UKI'=
s
signature addresses the integrity of the initramfs.  What about the integri=
ty of
the kdump initramfs (or for that matter the kexec initramfs)?  If the kdump
initramfs was signed, IMA would be able to verify it before the kexec.

As for the next paragraph, based on Coiby's response, please remove it.

thanks,

Mimi
>=20
> >=20
> > > >=20
> > > > And Coiby also mentioned that for kdump kernel incorrect ima-policy
> > > > loaded
> > > > by systemd could cause kdump kernel hang, and it's possible the boo=
ting
> > > > process may be stopped by a strict, albeit syntax-correct policy an=
d
> > > > users
> > > > can't log into the system to fix the policy. In these cases, allowi=
ng to
> > > > disable IMA is very helpful too for kdump kernel.
> > > >=20
> > > > Hence add a knob ima=3Don|off here to allow people to disable IMA i=
n kdump
> > > > kenrel if needed.
> >=20
> > ^kernel
>=20
> Will change.
>=20
> >=20
> > > >=20
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > ---
> > > > =C2=A0.../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > > > =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++++++++++++
> > > > =C2=A02 files changed, 27 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > > > b/Documentation/admin-guide/kernel-parameters.txt
> > > > index d9fd26b95b34..762fb6ddcc24 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -2202,6 +2202,11 @@
> > > > =C2=A0			different crypto accelerators. This option can
> > > > be
> > > > used
> > > > =C2=A0			to achieve best performance for particular HW.
> > > > =C2=A0
> > > > +	ima=3D		[IMA] Enable or disable IMA
> > > > +			Format: { "off" | "on" }
> > > > +			Default: "on"
> > > > +			Note that this is only useful for kdump kernel.
> >=20
> > Instead of "useful" I would prefer something clearer like "limited".
>=20
> Makes sense, will change.
>=20
> >=20
> > > > +
> > > > =C2=A0	init=3D		[KNL]
> > > > =C2=A0			Format: <full_path>
> > > > =C2=A0			Run specified binary instead of /sbin/init as
> > > > init
> > > > diff --git a/security/integrity/ima/ima_main.c
> > > > b/security/integrity/ima/ima_main.c
> > > > index f3e7ac513db3..07af5c6af138 100644
> > > > --- a/security/integrity/ima/ima_main.c
> > > > +++ b/security/integrity/ima/ima_main.c
> > > > @@ -27,6 +27,7 @@
> > > > =C2=A0#include <linux/fs.h>
> > > > =C2=A0#include <linux/iversion.h>
> > > > =C2=A0#include <linux/evm.h>
> > > > +#include <linux/crash_dump.h>
> > > > =C2=A0
> > > > =C2=A0#include "ima.h"
> > > > =C2=A0
> > > > @@ -38,11 +39,27 @@ int ima_appraise;
> > > > =C2=A0
> > > > =C2=A0int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
> > > > =C2=A0static int hash_setup_done;
> > > > +static int ima_disabled;
> >=20
> > Like the ima_hash_algo variable definition above, ima_disabled should b=
e
> > defined as __ro_after_init.
>=20
> Will add __ro_after_init.
>=20
> >=20
> > > > =C2=A0
> > > > =C2=A0static struct notifier_block ima_lsm_policy_notifier =3D {
> > > > =C2=A0	.notifier_call =3D ima_lsm_policy_change,
> > > > =C2=A0};
> > > > =C2=A0
> > > > +static int __init ima_setup(char *str)
> > > > +{
> >=20
> > is_kdump_kernel() should also be called here, before the tests below.=
=20
> > Something like:
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_kdump_kernel()) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_info("Warning ima setup option only permitted in kdump")=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Sure, will change as suggested.
>=20
> >=20
> > > > +	if (strncmp(str, "off", 3) =3D=3D 0)
> > > > +		ima_disabled =3D 1;
> > > > +	else if (strncmp(str, "on", 2) =3D=3D 0)
> > > > +		ima_disabled =3D 0;
> > > > +	else
> > > > +		pr_err("Invalid ima setup option: \"%s\" , please
> > > > specify
> > > > ima=3Don|off.", str);
> > > > +
> > > > +	return 1;
> > > > +}
> > > > +__setup("ima=3D", ima_setup);
> > > > +
> > > > +
> > > > +
> >=20
> > Remove the extraneous blank line.
>=20
> sure.
>=20
> >=20
> > > > =C2=A0static int __init hash_setup(char *str)
> > > > =C2=A0{
> > > > =C2=A0	struct ima_template_desc *template_desc =3D
> > > > ima_template_desc_current();
> > > > @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
> > > > =C2=A0{
> > > > =C2=A0	int error;
> > > > =C2=A0
> > > > +	if (ima_disabled && is_kdump_kernel()) {
> > > > +		pr_info("IMA functionality is disabled");
> > > > +		return 0;
> > > > +	}
> > > > +
> >=20
> > Even with the additional call to is_kdump_kernel() in ima_setup, please=
 keep
> > the is_kdump_kernel() test here as well.=C2=A0 Even though the code is =
self
> > describing, please add a one line comment emphasizing disabling IMA is
> > limited
> > to kdump.
>=20
> OK, will keep code here as this v1 is and add one line of comment at
> above.
>=20
> Thanks again.
>=20
> >=20
> > > > =C2=A0	ima_appraise_parse_cmdline();
> > > > =C2=A0	ima_init_template_list();
> > > > =C2=A0	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > > > --=20
> > > > 2.41.0
> > > >=20
> > >=20
> > >=20

