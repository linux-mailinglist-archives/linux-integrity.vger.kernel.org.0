Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0465119E5C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLJWoD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 17:44:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728626AbfLJWoD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 17:44:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAMbcgi142550
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:44:02 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wt2etcvh2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:44:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 10 Dec 2019 22:43:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 22:43:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAMhtZX56492178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 22:43:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BE8A4057;
        Tue, 10 Dec 2019 22:43:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05E25A405F;
        Tue, 10 Dec 2019 22:43:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Dec 2019 22:43:53 +0000 (GMT)
Subject: Re: [PATCH v10 6/6] IMA: Read keyrings= option from the IMA policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 17:43:53 -0500
In-Reply-To: <20191204224131.3384-7-nramas@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-7-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121022-0020-0000-0000-0000039654FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121022-0021-0000-0000-000021ED9844
Message-Id: <1576017833.4579.45.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_07:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912100186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-04 at 14:41 -0800, Lakshmi Ramasubramanian wrote:
> Read "keyrings=" option, if specified in the IMA policy, and store in
> the list of IMA rules when the configured IMA policy is read.
> 
> This patch defines a new policy token enum namely Opt_keyrings
> and an option flag IMA_KEYRINGS for reading "keyrings=" option
> from the IMA policy.
> 
> Updated ima_parse_rule() to parse "keyrings=" option in the policy.
> Updated ima_policy_show() to display "keyrings=" option.
> 
> The following example illustrates how key measurement can be verified.
> 
> Sample "key" measurement rule in the IMA policy:
> 
> measure func=KEY_CHECK uid=0 keyrings=.ima|.evm template=ima-buf
> 
> Display "key" measurement in the IMA measurement list:
> 
> cat /sys/kernel/security/ima/ascii_runtime_measurements
> 
> 10 faf3...e702 ima-buf
> sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3
> b7b .ima 308202863082...4aee
> 
> Verify "key" measurement data for a key added to ".ima" keyring:
> 
> cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
> grep ".ima" | cut -d' ' -f 6 | xxd -r -p |tee ima-cert.der |
> sha256sum | cut -d' ' -f 1
> 

The dot needs to be quoted, otherwise it matches any character.  I
would also limit the above command to the first instance (eg. grep -m
1 "\.ima).

> The output of the above command should match the sha256 hash
> in the "key" measurement entry in the IMA measurement list.

There are multiple hashes in a measurement list record.  Perhaps refer
to the 2nd hash as the "template hash".

Mimi

> 
> The file namely "ima-cert.der" generated by the above command
> should be a valid x509 certificate (in DER format) and should match
> the one that was used to import the key to the .ima keyring.
> The certificate file can be verified using openssl tool.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

