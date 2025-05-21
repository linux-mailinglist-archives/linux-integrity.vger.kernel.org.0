Return-Path: <linux-integrity+bounces-6269-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A84ABF4DA
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD34E1887896
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760F269CFA;
	Wed, 21 May 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WG5lWPVB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D17267F48;
	Wed, 21 May 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832070; cv=none; b=uXHENk+sl0tX9aDakITXXrpZcTAEd3QRtoeY6h7CLcx498F8iPBbWtyASs6T777vSZr68f0BT9NPzKomlyu8HftEMximBi5QmLblrv2wrl5O690VwOJg5m6pRt/e1FqBjGuZs58sM4KpsDHnJcJhJ7fW6xuDwAl3uJd1pS5/ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832070; c=relaxed/simple;
	bh=5BHjPodNxPkDFRb2pZOoLtV2R+N3FjkRVfnZRtvxEoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUkiypfEY0a7d9IF98cmx+/eM6e+K8e4tTfnLnb7Tk295P4Nw45Xq6EXZtpIw5Ov+D6u9F2/9+1XWVE+iccRGRg69Jvx6WHACg5LMPxvjQRRAYqs7x/ihM588+Pi97ERsvU30HCPAdx7vrr8uUdYu3fLYuSzlTNMUHO/lLomZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WG5lWPVB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7DXpH012569;
	Wed, 21 May 2025 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9njQgb
	HwVVKKgMPLZo8Fg1k9epS2wmidLMKCgwjiL4Q=; b=WG5lWPVBUw+Hh4ajtt6ve5
	SFnUkhSPWfHJ1+yq6plxE1SVz1pdDzfJ12Gw0+gvAb/W3P5D1WTAfIZ7YiQzEXTd
	xk09NGWS/+MayLrGQnDbr5ReSk3mV2iDifunrRypRzR97FeSaI5MwNxQeJGhOCGj
	As85eYQcOrgtnOIaSUCsBmqbdCwS1WSPQ9kG9DFiD+MBNJUDJk9wJuHQuGmwiS8V
	Gs20jUfFwKcZfgWaPSI9zCAKFF7wnxgBuC0X0BQRSGg8AHavPVDawlmqv/ttv/No
	InCbxTThy2Smv1h7uunAFFKl8rfdhiV9XLqTkGJ+MPqNwntvq9O1v5CdzVNZcd3Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rye6m4s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:54:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9JE5i015497;
	Wed, 21 May 2025 12:54:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnc7t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 12:54:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LCsBKq22938140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:54:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF4EA5805E;
	Wed, 21 May 2025 12:54:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E88BA58052;
	Wed, 21 May 2025 12:54:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.23.72])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 12:54:10 +0000 (GMT)
Message-ID: <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, coxu@redhat.com,
        ruyang@redhat.com, chenste@linux.microsoft.com
Date: Wed, 21 May 2025 08:54:10 -0400
In-Reply-To: <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
References: <20250515233953.14685-1-bhe@redhat.com>
	 <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMiBTYWx0ZWRfX+v9fZt+yWeWp /dzdbNrtWM3bCphbSBrlGm/yvLFy2lWUz/g+LEdXUpoRgQWgOBz+yyAO4+yUloNNpvFSogr9OFx rb1wj+jASPx8Wa37WnUXNWDh58J8YtDPbLpL1LuvWnLGbYv679hkIh0Z4T40Hr2/Y1rykuZjXDR
 zNsE+FJBBQVP1aSatPijD0oLTHt1UWn+xZFCsL4ELZgOTpYNp6ru/03UQ3mHFj0Pxaax4YPpbBn oIrhc8VkaaLXCkpGrjOki0kLdtDoMoack0RMbHhI2KdU60VvMR+esUlATvMqOMWGhuNJRTLVAkI 3MmPLcSBR+0Y+54sLhylMnBXPSseDXtsNbvVzqRrt6mqrQGNwo06g0dVsBV1ge3DY8C0e7O7jQ9
 yuqocjV0YqAsnWsEpTSlbz18ZC90ygYXXnasAp0SJoIJC62v+VWwrVBYOLMA2gRe3W7TYeM1
X-Authority-Analysis: v=2.4 cv=esrfzppX c=1 sm=1 tr=0 ts=682dccf5 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=UeMwZWw34uBX8khp:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=2HI49ejy6j84m9CP7MAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: J-RZBjokabeiWH5x4PVvyOY15NRYoHOn
X-Proofpoint-GUID: J-RZBjokabeiWH5x4PVvyOY15NRYoHOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210122

On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> CC kexec list.
>=20
> On 05/16/25 at 07:39am, Baoquan He wrote:
> > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > extra memory. It would be very helpful to allow IMA to be disabled for
> > kdump kernel.

The real question is not whether kdump needs "IMA", but whether not enablin=
g
IMA in the kdump kernel could be abused.  The comments below don't address
that question but limit/emphasize, as much as possible, turning IMA off is
limited to the kdump kernel.

> >=20
> > And Coiby also mentioned that for kdump kernel incorrect ima-policy loa=
ded
> > by systemd could cause kdump kernel hang, and it's possible the booting
> > process may be stopped by a strict, albeit syntax-correct policy and us=
ers
> > can't log into the system to fix the policy. In these cases, allowing t=
o
> > disable IMA is very helpful too for kdump kernel.
> >=20
> > Hence add a knob ima=3Don|off here to allow people to disable IMA in kd=
ump
> > kenrel if needed.

^kernel

> >=20
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > =C2=A0.../admin-guide/kernel-parameters.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++++++++++++++
> > =C2=A02 files changed, 27 insertions(+)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index d9fd26b95b34..762fb6ddcc24 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2202,6 +2202,11 @@
> > =C2=A0			different crypto accelerators. This option can be
> > used
> > =C2=A0			to achieve best performance for particular HW.
> > =C2=A0
> > +	ima=3D		[IMA] Enable or disable IMA
> > +			Format: { "off" | "on" }
> > +			Default: "on"
> > +			Note that this is only useful for kdump kernel.

Instead of "useful" I would prefer something clearer like "limited".

> > +
> > =C2=A0	init=3D		[KNL]
> > =C2=A0			Format: <full_path>
> > =C2=A0			Run specified binary instead of /sbin/init as
> > init
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index f3e7ac513db3..07af5c6af138 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -27,6 +27,7 @@
> > =C2=A0#include <linux/fs.h>
> > =C2=A0#include <linux/iversion.h>
> > =C2=A0#include <linux/evm.h>
> > +#include <linux/crash_dump.h>
> > =C2=A0
> > =C2=A0#include "ima.h"
> > =C2=A0
> > @@ -38,11 +39,27 @@ int ima_appraise;
> > =C2=A0
> > =C2=A0int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
> > =C2=A0static int hash_setup_done;
> > +static int ima_disabled;

Like the ima_hash_algo variable definition above, ima_disabled should be
defined as __ro_after_init.

> > =C2=A0
> > =C2=A0static struct notifier_block ima_lsm_policy_notifier =3D {
> > =C2=A0	.notifier_call =3D ima_lsm_policy_change,
> > =C2=A0};
> > =C2=A0
> > +static int __init ima_setup(char *str)
> > +{

is_kdump_kernel() should also be called here, before the tests below.=20
Something like:

+       if (!is_kdump_kernel()) {
+               pr_info("Warning ima setup option only permitted in kdump")=
;
+               return 1;
+       }

> > +	if (strncmp(str, "off", 3) =3D=3D 0)
> > +		ima_disabled =3D 1;
> > +	else if (strncmp(str, "on", 2) =3D=3D 0)
> > +		ima_disabled =3D 0;
> > +	else
> > +		pr_err("Invalid ima setup option: \"%s\" , please specify
> > ima=3Don|off.", str);
> > +
> > +	return 1;
> > +}
> > +__setup("ima=3D", ima_setup);
> > +
> > +
> > +

Remove the extraneous blank line.

> > =C2=A0static int __init hash_setup(char *str)
> > =C2=A0{
> > =C2=A0	struct ima_template_desc *template_desc =3D
> > ima_template_desc_current();
> > @@ -1184,6 +1201,11 @@ static int __init init_ima(void)
> > =C2=A0{
> > =C2=A0	int error;
> > =C2=A0
> > +	if (ima_disabled && is_kdump_kernel()) {
> > +		pr_info("IMA functionality is disabled");
> > +		return 0;
> > +	}
> > +

Even with the additional call to is_kdump_kernel() in ima_setup, please kee=
p
the is_kdump_kernel() test here as well.  Even though the code is self
describing, please add a one line comment emphasizing disabling IMA is limi=
ted
to kdump.

> > =C2=A0	ima_appraise_parse_cmdline();
> > =C2=A0	ima_init_template_list();
> > =C2=A0	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > --=20
> > 2.41.0
> >=20
>=20
>=20

thanks,

Mimi

