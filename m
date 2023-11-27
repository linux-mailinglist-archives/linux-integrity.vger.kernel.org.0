Return-Path: <linux-integrity+bounces-246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F27FAAE4
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 21:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4E1F20F10
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3045BE4;
	Mon, 27 Nov 2023 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ds9SRdHN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B2D5D
	for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2023 12:05:21 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARIgloX021961;
	Mon, 27 Nov 2023 20:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+xUXhS4/3B4bN7XQSnUhCueC+JS5GIu0nWdcYIldqRg=;
 b=ds9SRdHNFk9fNdXfoPZas6cuynOH7txPCwN8OfH/zzfRhj15piUHb3eDVQxoLtEZtmP1
 N38ofkhbT547bwZDGlHSg4r5RDQXBeFDv8lQecFCQKKLZAPCYnxrCwoG6sKaD6rcgb80
 PrPtQIpXUYBIaWLM0UiRQQT6A+X4YYvLa/FDI7PSQ0MYks+LagQ1/xVQZWN+sho/BV6s
 j6D0W7p1m0jZ9UdyHw7EbTTrMrI8lYx/2Ty97x9wpm5NancBOpN+j5b/vs8b/ExR+8vH
 g4m85+oT6giOTJfGQixVfef8DC7E3LjhyfvCuPN0RRK0RKm18cJqFlhDy+tgOuOk8iRw gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0mdj66g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 20:05:08 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARJRcsq014889;
	Mon, 27 Nov 2023 20:05:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0mdj64p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 20:05:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJOwvF025580;
	Mon, 27 Nov 2023 20:05:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkaweu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 20:05:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARK53sh17695388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 20:05:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A414858065;
	Mon, 27 Nov 2023 20:05:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC6458052;
	Mon, 27 Nov 2023 20:05:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 20:05:02 +0000 (GMT)
Message-ID: <fcb2271d-ad40-4c50-9b04-145e8fbeb224@linux.ibm.com>
Date: Mon, 27 Nov 2023 15:05:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: tis_i2c: Add compatible string nuvoton,npct75x
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        Dan Morav <dan.morav@nuvoton.com>, Dana Cohen <dana.cohen@nuvoton.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Peter Delevoryas <peter@pjd.dev>
References: <be92814061f20ed7ae6db4c0fab833cf4b7404b4.1701095990.git.lukas@wunner.de>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <be92814061f20ed7ae6db4c0fab833cf4b7404b4.1701095990.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x4gNCZHj2fsxikYexOkTjAtGoaTgOFCf
X-Proofpoint-GUID: yphYY0mXzpS_cO4_RncKfWYv6vfHmmlq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=974
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270139



On 11/27/23 09:42, Lukas Wunner wrote:
> Add "nuvoton,npct75x" as well as the fallback compatible string
> "tcg,tpm-tis-i2c" to the TPM TIS driver.  They're used by:

.. the TPM TIS I2C driver
> 
>    arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
>    arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> 
> And by all accounts, NPCT75x is supported by the driver:
> 
>    https://lore.kernel.org/all/60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com/
>    https://lore.kernel.org/all/20220808220839.1006341-8-peter@pjd.dev/
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index a897402cc36a..9511c0d50185 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>   #ifdef CONFIG_OF
>   static const struct of_device_id of_tis_i2c_match[] = {
>   	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "nuvoton,npct75x", },
> +	{ .compatible = "tcg,tpm-tis-i2c", },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, of_tis_i2c_match);

