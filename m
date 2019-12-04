Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78841129F3
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLDLQm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 06:16:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727331AbfLDLQm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 06:16:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4BCTLw052236
        for <linux-integrity@vger.kernel.org>; Wed, 4 Dec 2019 06:16:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnsvhxbcn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 04 Dec 2019 06:16:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 4 Dec 2019 11:16:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Dec 2019 11:16:35 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4BGY3f37290084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 11:16:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFBC74C046;
        Wed,  4 Dec 2019 11:16:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F7B4C040;
        Wed,  4 Dec 2019 11:16:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.222.210])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 11:16:33 +0000 (GMT)
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Date:   Wed, 04 Dec 2019 06:16:32 -0500
In-Reply-To: <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-6-nramas@linux.microsoft.com>
         <1575375945.5241.16.camel@linux.ibm.com>
         <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
         <1575403616.5241.76.camel@linux.ibm.com>
         <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120411-0012-0000-0000-00000370ED4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120411-0013-0000-0000-000021ACAD65
Message-Id: <1575458192.5241.99.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=932
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040089
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Mat Martineau]

On Tue, 2019-12-03 at 15:37 -0800, Lakshmi Ramasubramanian wrote:
> On 12/3/2019 12:06 PM, Mimi Zohar wrote:
> 
> > Suppose both root and uid 1000 define a keyring named "foo".  The
> > current "keyrings=foo" will measure all keys added to either keyring
> > named "foo".  There needs to be a way to limit measuring keys to a
> > particular keyring named "foo".
> > 
> > Mimi
> 
> Thanks for clarifying.
> 
> Suppose two different non-root users create keyring with the same name 
> "foo" and, say, both are measured, how would we know which keyring 
> measurement belongs to which user?
> 
> Wouldn't it be sufficient to include only keyrings created by "root" 
> (UID value 0) in the key measurement? This will include all the builtin 
> trusted keyrings (such as .builtin_trusted_keys, 
> .secondary_trusted_keys, .ima, .evm, etc.).
> 
> What would be the use case for including keyrings created by non-root 
> users in key measurement?
> 
> Also, since the UID for non-root users can be any integer value (greater 
> than 0), can an an administrator craft a generic IMA policy that would 
> be applicable to all clients in an enterprise?

The integrity subsystem, and other concepts upstreamed to support it,
are being used by different people/companies in different ways.  I
know some of the ways, but not all, as how it is being used.  For
example, Mat Martineau gave an LSS2019-NA talk titled "Using and
Implementing Keyring Restrictions for Userspace".  I don't know if he
would be interested in measuring keys on these restricted userspace
keyrings, but before we limit how a new feature works, we should at
least look to see if that limitation is really necessary.

Mimi

