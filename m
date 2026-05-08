Return-Path: <linux-integrity+bounces-9485-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OSKJ4Le/WmqkAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9485-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 15:00:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74764F6B55
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F17306887D
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C673101B6;
	Fri,  8 May 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qAlkhycX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BC192B75;
	Fri,  8 May 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244986; cv=none; b=b4o8OAmDGUYd9COsxpDIp6obFBTQMYuiPdOLiwcwDIwEoW406wCVzfoTUtJfogUbuUtb3PyACOrbFpccjzHJM4U8CpKaxGHgSbwvNYlDyKxk5KUk/ydToX2MgXkBTpEIbDGP5cbzUFgAtoTHZvcDWuIATlJdnaj6R4zJKaXbKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244986; c=relaxed/simple;
	bh=tA4Snu529quXZC37xhx99jFBAqJZX4GN4vW1VlzVJkY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DqN6JgYZ8ngH3cHWDhc65fLJPYyN8lyq5/UvI9IQVPBWsim2MfOO+EwmRdR85UqmmMJy9FWxijgEUULkz78ocLisG4pOG7btEGOsXMP/sbImouBYkfJVT+M2wf7+OYtoOL7Hqs8Wm792F57h3LVL7T0RCtfvAMSGu+qcMMLAhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qAlkhycX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647MdOX82752196;
	Fri, 8 May 2026 12:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CNT8qK
	90tO4DRCBa6Q1VeOcJ+2/2PVh6nuYm8vkCehA=; b=qAlkhycXw4gtpTG5+LJ5po
	PDVZo4vzWxnyxrQaoUzBiIsXIsMNix5CIEDobA/ATdlrcmXwMhD1qYTatiIBpqAv
	lqb3/Awy6xerfM7kQbzUJmxlW+IxdOXOCD+of1TSgBLYmlJbf3lybKkxlOiuhevS
	MQkvG8iuM4eZUHuU18k7SBJrGO5JX1DZ8oca16zVvCqo8jZIiWAmfWByFXh5CcrK
	jhYt0L0yUSpCAM0ryVCcTyX1L6iHKZJJXgYkCPOkO05O6SwA4RNRKQgTyyXRrPz3
	czD15LJUqzUQFWBNLYBJfNiTQafMKDk7mTHJm4616FXcWJWpYOAmk5UX6XrgBOvg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x53rqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 12:55:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648CdfU6020024;
	Fri, 8 May 2026 12:55:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywga2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 12:55:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648CthT133358464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 12:55:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3C65806B;
	Fri,  8 May 2026 12:55:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25CE15806F;
	Fri,  8 May 2026 12:55:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.52.128])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 12:55:41 +0000 (GMT)
Message-ID: <2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: David Safford <david.safford@gmail.com>,
        Jonathan McDowell	
 <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <af2nhZyyNaP7LM3w@e129823.arm.com>
References: <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
	 <afrXmRiq7XvSe6yN@e129823.arm.com>
	 <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
	 <aftIuPwNeuzc9nY1@e129823.arm.com>
	 <9d1af933ef218b159762884357d127e3644dfe2c.camel@linux.ibm.com>
	 <afwoDgaJxmKwOhXp@e129823.arm.com>
	 <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
	 <afyIbW5cljh5ZvTL@e129823.arm.com> <afzwJn+5r15jFxrB@e129823.arm.com>
	 <77ad49cca1acf707f4152ed3e2066b2f24c90c16.camel@linux.ibm.com>
	 <af2nhZyyNaP7LM3w@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 08:55:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMSBTYWx0ZWRfX0GEHvismOr/n
 yL3KnjqVPl3k3o5t4By0xsuVICtLo4mcf2LhMsMA7D8UtFoAk/kD6YiWYgHyq+wz4p//8yQGRF/
 yrLxJ1RBz3LvkUtlsB5sSapQ4lEMuatN7zIFALpVLfaChy+BYG53J8xK815TxzQ+wPwdIhTMyiT
 FtdSxlz+hckgfS1c2tJd/ggZh4KhYZZaHAjIstlJ6A3prqSlczq+T3vYhPcT7qr727p3hBdAEH+
 0UTiFJc3eEkAtS5jf7NXNekOdHwmJ7LeJBm7Kd8/t4bmC/6W9lskHXHaeCMmJsnUK2FnzGr+zcW
 JAgFEuWYdLedfhuE1LAkLJSFuH+IXt+3QeL1/YgfPF+AlYFK7UsfP0gvxmOfyanJ++T8hEzBnFC
 ucT8TXRTykJLWhKbRum9ZwKl+7qj9pq9V9YxF/IOiTuf/wup7a8D8A2wlab9vD/fHnuTb5laOxo
 MSW9S0ZC/gxY3rAVbXw==
X-Proofpoint-ORIG-GUID: 2l_3ko0Exadu_5ZF5KPsMugHlnC-OGcV
X-Proofpoint-GUID: kB6MJOa0lJ5Hl5Uuk4_weLGs3pN_k0Vo
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fddd51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=jeveBUE32ww0wtG-KO0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080131
X-Rspamd-Queue-Id: E74764F6B55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9485-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Fri, 2026-05-08 at 10:06 +0100, Yeoreum Yun wrote:

> > The kernel selftests caused the measurements between late_initcall and
> > late_initcall_sync.  After disabling all of the kernel selftests, there=
 weren't
> > any measurements. Re-enabling the FIPS selftests on PowerVM LPAR result=
ed in
> > measurements.  (I didn't try re-enabling any of the other selftests.)
> >=20
> > CONFIG_FIPS_SIGNATURE_SELFTEST=3Dy
> > CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=3Dy
> > CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=3Dy
>=20
> Thanks for shraring this ;)
>=20
> I found the reason for those mesaurements. Those come from the
> request_module() and usermode-thread generates them while handling module
> loading request for crypto-x962(ecdsa-nist-p256).
> Since it's not a real kernel module,
> I confirmed file measurements between late_initcall and
> late_initcall_sync are gone for modeprobe with below change:
>=20
> @@ -1246,9 +1250,14 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
>   */
>  static int ima_kernel_module_request(char *kmod_name)
>  {
>         if (strncmp(kmod_name, "crypto-pkcs1(rsa,", 17) =3D=3D 0)
>                 return -EINVAL;
>=20
> +       if (IS_BUILTIN(CONFIG_CRYPTO_ECDSA) &&
> +           (strncmp(kmod_name, "crypto-x962(ecdsa", 17) =3D=3D 0))
> +               return -EINVAL;
> +
>         return 0;
>  }
>=20
>  Though this is the only request_module() call between
>  late_initcall and late_initcall_sync, but I also confirmed there're
>  request_modules() call before ima initalisation before "late_initcall":
>=20
> /*
>  * NOTE: kmod_name is printed on ima_kernel_module_request()
>  */
>=20
> // This is called from module_init(stm_core_init) -> device_initcall()
> // which is in driver/hwtracing/stm/core.c (built-in)
> [    1.421986] ima: kmod_name: stm_p_basic
> ...
> [    1.444900] ima: kmod_name: crypto-pkcs1(rsa,sha512)
> [    1.444903] ima: kmod_name: crypto-pkcs1(rsa,sha512)-all
> ...
> [    1.452029] ima: kmod_name: crypto-cbc(aes)
> [    1.465321] ima: kmod_name: crypto-cbc(aes)-all
> ...
> [    1.467845] Key type encrypted registered
> [    1.467848] AppArmor: AppArmor sha256 policy hashing enabled
>=20
>  // IMA is initailised at late_initcall level.
> [    1.467850] ima: [init_ima_late:1336]
>=20
> If IMA should care request_module() from kernel before IMA init,
> I think there is no way to solve except queuing those events
> (kernel_load_data/kernel_load_post_data and open for module binary etc.)
> though it breaks "measure before use" principle since IMA couldn't
> measure at that time.
>=20
> But if you don't care about those things -- some events happend before
> IMA init, I think your suggestion -- controlling the init time of ima_ini=
t()
> via a Kconfig option is good and ignoring some usermodehelper request
> including request_module() before IMA initialisation upto user by that op=
tion.

Thank you for the complete analysis.  The early measurements before the TPM=
 is
initialized is a problem that needs to be addressed.  As to whether the sol=
ution
will require queueing is yet to be determined. (Roberto has some thoughts o=
n
addressing it.) This discussion makes it clear that simply delaying IMA
initialization by moving it from late_initcall to late_initcall_sync could =
miss
measurements.  That said, exposing it as an opt-in Kconfig for those who ac=
cept
the risk is a sensible pragmatic compromise.

Mimi

