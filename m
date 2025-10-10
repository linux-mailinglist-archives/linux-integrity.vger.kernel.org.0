Return-Path: <linux-integrity+bounces-7417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB522BCDFF0
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 18:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A222D1A64C24
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD52FC897;
	Fri, 10 Oct 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mMwuySSw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4982F999F;
	Fri, 10 Oct 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115280; cv=none; b=SGdCYcDaWz/V3QCQalpaGUD/oOy/7zYgTapg6PItGxKg0mkfYvkKj/SGz7N2F3moVidW+9wFR33BOMwfhNlJIY0ZrAeHaBlO4SrnJNk2UcLKB2ruoNPty/AD6mOuGcpH/z1zWPZCugDHDICwxi/NnBLoyGmPc3/yF5Ru6IN4nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115280; c=relaxed/simple;
	bh=u0e8XQ6G1i6kEL4eGPd1j40PN0GyODrADt1SEysAYVY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AvAZ8ZfTO+MccFD6t8dQrPCB/BT466A7xFFcN4P1+AaHveckDEp4Ifm8zdTvxlMxoBMYaJfBlaPbMqHQYvja7yzK4x3zv4j+Rj7/OfcqOq7ytuF1RdtSFB3H8V7JZMYQaU62XeW/vJCVpv4PAJUAm/ETjwCzt4SEibNh8oNmsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mMwuySSw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A98b5i030365;
	Fri, 10 Oct 2025 16:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=95y+YZ
	TC4KTW0yO/WMS40IPglxxiJMZ4+7GmtiaZTD0=; b=mMwuySSwKhgQuUxGVmKj+w
	ozyknAXyLvNxlnlCr2J4AKSdFwlT6BEaj1gNiHfc2mSGeujqZgIR8ivnEA4KdWuT
	b0VNZH/zCkuT7uzG1MAvUV5ISWtvNN9R6umkVFxaPM9VdX8pOilOc/xL7HkxUsUW
	VNsoxiaMZe40m2dQ22OkmiD2A2uSpUhesj98YJ96HoDcFs0YikEWxZDpFNN0wOPV
	TAbpYYYfu6mIn3QAQVbqF/NL7vOMVz7X9STogbZdyX7XyV99Tu3BXCfvN/cubYaW
	QOk1ySn8EG/hWb4En3eqGMIED2D3EwPsQcnWk12b5Kd/Ynuqi9fs46kbagnBd8YQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81upph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 16:53:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59AGWfNR025208;
	Fri, 10 Oct 2025 16:53:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81uppf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 16:53:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFwFr7020946;
	Fri, 10 Oct 2025 16:53:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9n2t9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 16:53:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59AGrUux27394570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 16:53:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B55358053;
	Fri, 10 Oct 2025 16:53:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30BC558043;
	Fri, 10 Oct 2025 16:53:29 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.38.189])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 16:53:29 +0000 (GMT)
Message-ID: <282070d5c0dd68140ae221833ea8c5ba4baada4f.camel@linux.ibm.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        John Johansen	
 <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu	 <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack	 <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton	 <mortonm@chromium.org>,
        Casey
 Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa	
 <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Bouchinet	
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-67-paul@paul-moore.com>
	 <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Oct 2025 12:53:28 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sMspvsbeEYMZd56uxP263MY5NlpRRhhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6LhxHBmsWFBx
 3aI1xza4K5HELsRg4aZb8XKAxaNadPLEO6C6FN8vzXIrfCrvXCfXG2y20CExpRHqM0YsEnazAMW
 FzincpS6UCv1tEEiBkvUBA5j3vmQtTgZV6lECpRIMJqr73hBUBJ7VG0Fms3kgdNHPY5SpQsSc42
 2PBDCLo3K9bqDAASG2AmlaLB3NFcXe9VAN1c+Y7PGNPna5yvLF0BB53xUCIP5M3N0KRwEvvRBfk
 BDAPzQc3Wu7kRPVVI3j4vZawzZlftj8p1vDFoLZAhsGMR+zC+ZisSL7OKlD5F2inlqtdxwaPOga
 5fodH7kB7b6eUqhm9pfVmB2c+odAHvbvEJekZHS4mfVEj+Xvn88aTjt1QXYFlE7RwUs/xnUQAlK
 gcnqMXHIYzQ2EwcsNEti6AA6TS6vbA==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e93a0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=xVhDTqbCAAAA:8 a=i0EeH86SAAAA:8
 a=QOsjzGcq3k85sNK84WMA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6xTVJMUoGr_GNH_GdHYfdirLmTHZJ5hX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, 2025-09-30 at 16:11 -0400, Paul Moore wrote:
> On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > evm_init_secfs(), to work around the fact that there is no "integrity" =
LSM,
> > and introduced integrity_fs_fini() to remove the integrity directory, i=
f
> > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > scenario of being called by both the IMA and EVM LSMs.
> >=20
> > This patch does not touch any of the platform certificate code that
> > lives under the security/integrity/platform_certs directory as the
> > IMA/EVM developers would prefer to address that in a future patchset.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > [PM: adjust description as discussed over email]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/integrity/evm/evm_main.c  |  3 +--
> >  security/integrity/evm/evm_secfs.c | 11 +++++++++--
> >  security/integrity/iint.c          | 14 ++++++++++++--
> >  security/integrity/ima/ima_fs.c    | 11 +++++++++--
> >  security/integrity/ima/ima_main.c  |  4 ++--
> >  security/integrity/integrity.h     |  2 ++
> >  6 files changed, 35 insertions(+), 10 deletions(-)
>=20
> I appreciate you reviewing most (all?) of the other patches in this
> patchset, but any chance you could review the IMA/EVM from Roberto?
> This is the only patch that really needs your review ...

Paul, I'm sorry for the long delay in reviewing and testing this patch set.=
  It
wasn't enough to just review this one patch, but it needed to be reviewed i=
n
context.

The initcall ordering is extremely important for IMA. IMA-measurement needs=
 to
be initialized after the TPM, otherwise IMA goes into TPM-bypass mode.  As
expected, the initcall ordering seems to be fine.  However this patch set
modifies the initcall debugging.

The kernel boot command line option "initcall_debug" outputs "entering init=
call
level:" messages for each of the initcall levels, and "calling ...." and
"initcall ..." messages for the individual initcalls.

For example,
[ 0.896556] entering initcall level: arch
[ 0.896556] calling report_snp_info+0x0/0xd0 @ 1
[ 0.896556] initcall report_snp_info+0x0/0xd0 returned 0 after 0 usecs

With this patch set, the "calling ..." and "initcall ..." messages will not=
 be
emitted for the LSMs. In lieu of these messages, the patch set defines a ne=
w
boot command line option "lsm.debug", which outputs "LSM: entering ....
initcall".

For example,
[ 2.225821] calling security_initcall_late+0x0/0xc0 @ 1
[ 2.225825] LSM: running ima late initcall

Regardless as to whether the performance information is actually necessary,=
 the
initcall debugging change should probably be documented.  Maybe update
initcall_debug to reference lsm.debug in Documentation/admin-guide/kernel-
parameters.txt.

Mimi

