Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D58112A8A1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2019 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYRIw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Dec 2019 12:08:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14088 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYRIw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Dec 2019 12:08:52 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBPH7H2Z053080;
        Wed, 25 Dec 2019 12:08:49 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1f3e296t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 12:08:49 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBPH4wls008891;
        Wed, 25 Dec 2019 17:08:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 2x1b1741et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 17:08:48 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBPH8lrx29294896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Dec 2019 17:08:47 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A15BD6E04E;
        Wed, 25 Dec 2019 17:08:47 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F8B76E054;
        Wed, 25 Dec 2019 17:08:47 +0000 (GMT)
Received: from [9.80.238.60] (unknown [9.80.238.60])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 25 Dec 2019 17:08:47 +0000 (GMT)
Subject: Re: [PATCH 6/8] security: keys: trusted: add PCR policy to TPM2 keys
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
References: <1575781600.14069.8.camel@HansenPartnership.com>
 <1575781957.14069.16.camel@HansenPartnership.com>
 <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org>
 <1575914591.31378.11.camel@HansenPartnership.com>
 <59E96950-5803-4231-88B2-33278357F934@infradead.org>
 <1575918695.31378.18.camel@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <f3e2e163-1754-1360-1454-70391aed8b95@linux.ibm.com>
Date:   Wed, 25 Dec 2019 12:08:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1575918695.31378.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_05:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=871 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912250146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/9/2019 2:11 PM, James Bottomley wrote:
> Plus, I know of no policy statement that's anywhere near 127 bytes
> long, so there's no problem with doing the single byte fixed length
> that DER requires.

Is "a policy statement" the TPM command?

PolicyOr takes a list of hashes.  A typical policy may only have 3
sha256 hashes, but it could potentially be 8 sha384 hashes.

PolicySigned has a policy with a 256 byte public key and a TPM
command with a 256 byte signature.

In general, since the TPM input command buffer is 1 - 1.5k,
that's a reasonable value for input parameters.

