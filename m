Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87B13F67E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jan 2020 20:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAPTEh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jan 2020 14:04:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33412 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388538AbgAPTEc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jan 2020 14:04:32 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GJ3hlt055469
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 14:04:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhferckf9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Jan 2020 14:04:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 16 Jan 2020 19:04:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Jan 2020 19:04:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GJ4OtK38207536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 19:04:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B425205F;
        Thu, 16 Jan 2020 19:04:24 +0000 (GMT)
Received: from dhcp-9-31-102-70.watson.ibm.com (unknown [9.31.102.70])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2275352052;
        Thu, 16 Jan 2020 19:04:24 +0000 (GMT)
Subject: Re: Question on signing the IMA signing key for kernel trusted
 keyrings?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Clay Chang <clayc@hpe.com>, linux-integrity@vger.kernel.org
Date:   Thu, 16 Jan 2020 14:04:23 -0500
In-Reply-To: <20200116183918.GA14177@blofly.tw.rdlabs.hpecorp.net>
References: <20200116183918.GA14177@blofly.tw.rdlabs.hpecorp.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011619-0020-0000-0000-000003A14A8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011619-0021-0000-0000-000021F8CAA3
Message-Id: <1579201463.5857.38.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-17 at 02:39 +0800, Clay Chang wrote:
> Hi,
> 
> We know that IMA or EVM signing key must be signed by the .builtin_trusted_keys.
> In the .builtin_trusted_keys keyring of a fresh CentOS, for example,
> there are public keys created by CentOS. And the private key counterparts
> were not available publicly. So I think there is technically no way for
> others to sign the IMA or EVM key by the private keys of those CA.
> 
> Is there a possibility of getting the IMA or EVM signing keys signed
> (probably by the public key in .builtin_trusted_keys) without rolling own
> CA and re-gen the kernel?

If the kernel was built with CONFIG_SYSTEM_EXTRA_CERTIFICATE, the
customer could insert their public key post build.[1]  This would
obviously require the kernel to be resigned.

I agree there needs to be a simpler way of including a customer key,
without requiring them to resign the kernel.

Mimi

[1] c4c361059585 ("KEYS: Reserve an extra certificate symbol for
inserting without recompiling")

