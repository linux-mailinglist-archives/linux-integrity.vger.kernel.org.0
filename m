Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD430C837
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhBBRpD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 12:45:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237796AbhBBRnA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 12:43:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 112HWJrV069184;
        Tue, 2 Feb 2021 12:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Pi2sm5SYvhLY3uiRslPwP6Z1VEtRopytEPp7U0KtnF8=;
 b=Hryrx3wwdqNoNjMsPDOcNNw2BkBspZxjkxu0viWpKVa7G4q4Mr9T646A5YpYe78CbVzC
 R49c1eFOL+zNKnOw9CbgRoPlP6Q1/yGzsGaE26MMsvFxlYQQ1WUfHe93+aQcD08mFhPf
 xGcqUI7whMwZu5x4PylG240Eqctqud7j07c/xzBxKG7mryRKTZMmBfobMoomeSnuBP/q
 mG/cogmCtpUWTv4yRWaMsKf3X18QqKqZ0m6AtAt7lgQxGaNpsTu+ITeNijghIytplRzL
 pr8Zugvk1tjPM0eJWM63O79YY5s95Obi8ySYXnF8ayuYhjT5NF5YuH7y9QdRk26f2rcE JA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36faxe0vs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 12:42:16 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 112Hg0YF001057;
        Tue, 2 Feb 2021 17:42:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 36f3kv3w32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 17:42:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 112HgFG730998958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 17:42:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F296124052;
        Tue,  2 Feb 2021 17:42:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FB48124053;
        Tue,  2 Feb 2021 17:42:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 17:42:15 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] ima_evm_utils: Add tests for ECDSA signature
 checking
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
References: <20210202155625.3555769-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3e320725-6f97-43b9-070d-129696fe17e0@linux.ibm.com>
Date:   Tue, 2 Feb 2021 12:42:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202155625.3555769-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_08:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/2/21 10:56 AM, Stefan Berger wrote:
> This series of patches fixes the calculation of the keyid in the
> sign_verify.sh script when it runs on older distros, such as CentoOS 7
> or Ubuntu Xenial, and then adds ECDSA signature checking using elliptic
> curve keys.

This series passes all relevant Travis tests. Te one failure seems 
unrelated to the modifications in this series.

https://travis-ci.com/github/stefanberger/ima-evm-utils/builds/215764182


>
>     Stefan
>
> Stefan Berger (2):
>    ima_evm_utils: Fix calculation of keyid for older distros
>    ima_evm_utils: Add testing with elliptic curves prime192v1 and 256v1
>
>   tests/gen-keys.sh      | 20 ++++++++++++++++++++
>   tests/sign_verify.test | 16 ++++++++++++++++
>   2 files changed, 36 insertions(+)
>

