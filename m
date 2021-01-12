Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C732F3F97
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 01:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbhALW3i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 17:29:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394596AbhALW3R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 17:29:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CM27D9023082;
        Tue, 12 Jan 2021 17:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ivZjNQ6TuZE1AU/YgDm07Ccl03ImODR1VBP4C1GIM5w=;
 b=rIccY9wnUJqq+xvYBbEY4RgzwRESGhIs6s1mrdkCWaS+g2AbmbPwhhDxoPqUo322KB5q
 dEvjngTJEditi04iIE7dR4WxSr2OSOBwVc24+QVFSSGw2h4RIfyoZxzT0GQ/tyFTOCPL
 V9mns2ZxQvwmvMjTM++W+zgDL1fiB/fUKPlvXpfIyxB4fbZsndq8c0vMZZwvhGA4uJ42
 KnLR3u//7KP6RczB4lAXGdDRfsq7lQlpPkP55m9ViiQVgRd5Q9yBKEyuwuplu0By9JBK
 TfZND6hHQy/aQYpls38jwHkXZq8AdXZeA1ShN/9lDGzHgyVqPlTBJcjRN5ub8DkdrXJG qA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 361jsvaj8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 17:28:34 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CMNJ9W028039;
        Tue, 12 Jan 2021 22:28:33 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 35y44916rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 22:28:33 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CMSXN639452966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 22:28:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD87AC05E;
        Tue, 12 Jan 2021 22:28:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51DB4AC05B;
        Tue, 12 Jan 2021 22:28:33 +0000 (GMT)
Received: from [9.80.236.95] (unknown [9.80.236.95])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jan 2021 22:28:33 +0000 (GMT)
Subject: Re: IMA appraisal with TPMv2?
To:     "Chang, Clay (HPS OE-Linux TDC)" <clayc@hpe.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <CS1PR8401MB036099EF243892F90D07D56CBCD00@CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <c94e3587-ca85-21ec-bafb-5bf1a9fc954e@linux.ibm.com>
Date:   Tue, 12 Jan 2021 17:28:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB036099EF243892F90D07D56CBCD00@CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_16:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=895 clxscore=1011 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/6/2021 5:47 AM, Chang, Clay (HPS OE-Linux TDC) wrote:
> Hi,
> 
> As I know, IMA appraisal with digital signature uses the public key on the .ima
> keyring for verification, and the public key needs to be signed by a certificate
> embedded into the kernel (CONFIG_SYSTEM_EXTRA_CERTIFICATE). While this approach
> looks fine, it requires kernel re-gen and re-sign in the context of secure boot.
> 
> My question is that for IMA appraisal, is it possible to verify the signature
> with the TPMv2? My intention is leverage the TPMv2 device and to avoid the
> kernel re-gen/re-sign.
> 
> For signing, I know I need a tool that uses TPMv2 to sign the executable and
> write the signature to the xattr of the file.

I don't understand the re-sign piece, so this may not make sense.

The TPM can certainly do signature verification as long as you can load the
public key.  However

- It will be very slow compared to software.
- If you can load the public key, can't you do the verification in SW?

The two main use cases for TPM signature verification are:

- In environments where SW does not have crypto.
- When the TPM is producing a ticket for a subsequent TPM operation.
