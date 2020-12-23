Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D682E1F0B
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 17:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLWP7o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 10:59:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgLWP7o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 10:59:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BNFYIXJ164382;
        Wed, 23 Dec 2020 10:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l5X8xjAD1dP6zpYhqiITFqXrFCYkdR6RvNjSajXqmto=;
 b=RcNKM70XW4uaMsN9+WSEEIVN1L+fTGd1wJGDbnZgSng+9UAkDQGzyDHtjGKH/fQSNqRG
 jR7X/f4P1fcqe81bhMDxuLXlLFu/LXbDypQN+wQuKCC3vpDuTSu4tmEXJ/syjzR8oqQ/
 v8Plu/U/4sVtq2bgqGaz3YNPlfG1/rb1VVUQSZq9dTUqKEt3x/Gh+IJZTxZIM5HEzJTY
 YI/pg7EDWfDIyvRdG4KPJIsiE6c/6sBmwR1hx0HxbTA0JPzGNRIhdvWAZRkOVdo3UobM
 FghOWJabooY10dBZtljdQkikb/Gw3MgOPxZnXBIh4Ag7DOCRZpT2KBp4ik/IhB/S0Ey1 hg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35m7xx9p0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 10:58:59 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BNFvjfS003618;
        Wed, 23 Dec 2020 15:58:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 35m62n195c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 15:58:59 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BNFwwZr35324350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 15:58:58 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585D3124052;
        Wed, 23 Dec 2020 15:58:58 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159B112405A;
        Wed, 23 Dec 2020 15:58:58 +0000 (GMT)
Received: from [9.80.231.19] (unknown [9.80.231.19])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Dec 2020 15:58:57 +0000 (GMT)
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
 <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
 <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
 <d1775d709b3b88b494e95fff6dbdbda72e1e3b61.camel@HansenPartnership.com>
 <TU4PR8401MB10556D3CE22216CC6B15B57EABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <ca2df3f0-a662-e09f-1a4c-687d44180bfb@linux.ibm.com>
Date:   Wed, 23 Dec 2020 10:58:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <TU4PR8401MB10556D3CE22216CC6B15B57EABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_07:2020-12-23,2020-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/30/2020 5:50 PM, Elliott, Robert (Servers) wrote:
> Yes, they are in
> * TCG PC Client Platform TPM Profile Specification for TPM 2.0
>    Version 1.05, Revision 14, 4 September 2020
> * Trusted Platform Module Library Part 2: Structures
>    Family 2.0, Level 00 Revision 1.59, 8 November 2019
> 
> I don't know if anyone has started implementing SHA-3 for PCRs.

AFIAK, no for SHA-3

Generally, TPM vendors do not implement optional features.  Since
applications cannot use them if they want interoperability, it
increases the TPM cost with no perceived benefit.

SHA-384, ECC NIST-P384, and RSA-3072 recently became mandatory.



