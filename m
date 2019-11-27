Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17A210B6D0
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 20:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfK0TdH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 14:33:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58144 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727803AbfK0TdE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 14:33:04 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARJWjKK179255
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 14:33:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whrgmf0my-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 14:33:02 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Nov 2019 19:33:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Nov 2019 19:32:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xARJWuS458196162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 19:32:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A3B011C052;
        Wed, 27 Nov 2019 19:32:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74A1711C050;
        Wed, 27 Nov 2019 19:32:55 +0000 (GMT)
Received: from dhcp-9-31-103-87.watson.ibm.com (unknown [9.31.103.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Nov 2019 19:32:55 +0000 (GMT)
Subject: Re: [PATCH v9 6/6] IMA: Read keyrings= option from the IMA policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 27 Nov 2019 14:32:54 -0500
In-Reply-To: <20191127015654.3744-7-nramas@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-7-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112719-0008-0000-0000-000003391467
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112719-0009-0000-0000-00004A581E18
Message-Id: <1574883174.4793.318.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=3 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-26 at 17:56 -0800, Lakshmi Ramasubramanian wrote:
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

The example is really too colloquial/verbose.  Please truncate it,
leaving just a sample "key" policy rule, with directions for verifying
the template data against the digest included in the measurement list.

> 
> Sample IMA Policy entry to measure keys
> (Added in the file /etc/ima/ima-policy):

Remove the above.

Sample "key" measurement rule:

> measure func=KEY_CHECK keyrings=.ima|.evm template=ima-buf
> 
> Build the kernel with this patch set applied and reboot to that kernel.
> 
> Ensure the IMA policy is applied:
> 
> root@nramas:/home/nramas# cat /sys/kernel/security/ima/policy
> measure func=KEY_CHECK keyrings=.ima|.evm template=ima-buf
> 
> View the initial IMA measurement log:
> 
> root@nramas:/home/nramas
> # cat /sys/kernel/security/ima/ascii_runtime_measurements
> 10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate
> 
> Now, add a certificate (for example, x509_ima.der) to the .ima keyring
> using evmctl (IMA-EVM Utility)
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>  547515640 ---lswrv      0     0  keyring: .ima
> 
> root@nramas:/home/nramas# evmctl import x509_ima.der 547515640
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>  547515640 ---lswrv      0     0  keyring: .ima
>  809678766 --als--v      0     0   \_ asymmetric: hostname: whoami signing key: 052dd247dc3c36...
> 
> View the updated IMA measurement log:
> 
> root@nramas:/home/nramas#

Remove everything up to here and simply say something like:

Display "key" measurement in the IMA measurement list:

> # cat /sys/kernel/security/ima/ascii_runtime_measurements

> 10 3adf... ima-buf
> sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3
> b7b .ima 308202863082...4aee


> root@nramas:/home/nramas#

Remove this string from all the commands.
> 
> For this sample, SHA256 should be selected as the hash algorithm
> used by IMA.
> 
> The following command verifies if the SHA256 hash generated from
> the payload in the IMA log entry (listed above) for the .ima key
> matches the SHA256 hash in the IMA log entry. The output of this
> command should match the SHA256 hash given in the IMA log entry
> (In this case, it should be
> 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b)

Previously you didn't use the hash value, but ".ima" to locate the
"key" measurement in the measurement list.  In each of the commands
above, it might be clearer.

> 
> root@nramas:/home/nramas

ditto

> # cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> | grep
> 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b | 

> cut -d' ' -f 6 | xxd -r -p |tee ima-cert.der | sha256sum | cut -d' '
> -f 1
> 
> The above command also creates a binary file namely ima-cert.der
> using the payload in the IMA log entry. This file should be a valid
> x509 certificate which can be verified using openssl as given below:
> 
> root@nramas:/home/nramas

ditto


> # openssl x509 -in ima-cert.der -inform DER -text
> 
> The above command should display the contents of the file ima-cert.der
> as an x509 certificate.

Either the comments should be above or below the commands, not both.

> 
> The IMA policy used here allows measurement of keys added to
> ".ima" and ".evm" keyrings only. Add a key to any other keyring and
> verify that the key is not measured.

This comment would be included, if desired, when defining the policy
rule, not here.

Mimi

