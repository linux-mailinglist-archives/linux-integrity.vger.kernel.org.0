Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA22E1074
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 00:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgLVXCe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 18:02:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726615AbgLVXCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 18:02:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMsDRX165581;
        Tue, 22 Dec 2020 18:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zz4SMB61qEYh82fBXNJFG2tiluDKf+DNmmx+H7ilapo=;
 b=Z1c4rs8wf5lxrl13fDZNZDzST6mmc+CvpTxMRSDLK/OHm7DnDod3PFJBRRyyGzcork0A
 X2nsJsOe7nQrqBjdE8tRbPhqW83nsDumGIUUc89Pf0JuaAW0ImhmMTGEnsJ+ck1Ha784
 Q6pmmqBbhA4eSTHDxM53zrFOKVMfTNhTwVsAerPJUKJPNiXFjtPQDTztXdUobXNjc5pA
 0IPXNW3sTZ5xmZLZR7fe1yDNfTCGIewJIPBq9BX8/lsnd/cpdK4nxUe2iKStB4TTUHht
 QPuV8qVUmPOy6jZrz1z+XvY85/BW3+0mb2ii193NvCLThQGhNjcMTGdPwO6KzwrnmNPy vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kt0fr44p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 18:01:47 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMN1le5023390;
        Tue, 22 Dec 2020 18:01:47 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kt0fr43y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 18:01:47 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMvEeS000374;
        Tue, 22 Dec 2020 23:01:46 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 35k02eubxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 23:01:46 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMN1j8924379672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 23:01:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159206A047;
        Tue, 22 Dec 2020 23:01:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E3886A04F;
        Tue, 22 Dec 2020 23:01:44 +0000 (GMT)
Received: from [9.85.203.88] (unknown [9.85.203.88])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 23:01:44 +0000 (GMT)
Subject: Re: [PATCH v14 3/5] security: keys: trusted: fix TPM2 authorizations
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
References: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
 <20201129222004.4428-4-James.Bottomley@HansenPartnership.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <dfd33d3d-8e1c-8acf-a3aa-3b62659d5d68@linux.ibm.com>
Date:   Tue, 22 Dec 2020 18:01:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201129222004.4428-4-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012220163
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/29/2020 5:20 PM, James Bottomley wrote:
> 
> Note this is both and enhancement and a potential bug fix.  The TPM
> 2.0 spec requires us to strip leading zeros, meaning empyty
> authorization is a zero length HMAC whereas we're currently passing in
> 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> makes the Microsoft TPM emulator work with trusted keys.

1 - To be precise, it strips trailing zeros, but 20 bytes of zero
results in an empty buffer either way.

"
Part 1 19.6.4.3	Authorization Size Convention

Trailing octets of zero are to be removed from any string before it is used as an authValue.
"


2 - If you have a test case for the MS simulator, post it and I'll give it a try.

I did a quick test, power cycle to set platform auth to empty, than
create primary with a parent password 20 bytes of zero, and the
SW TPM accepted it.

This was a password session, not an HMAC session.

