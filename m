Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA2E2218
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfJWRw3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 13:52:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730513AbfJWRw3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 13:52:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NHXRu2075400
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 13:52:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vtshu57m5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 13:52:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 18:52:25 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 18:52:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NHqLjt58523784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 17:52:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 916004C052;
        Wed, 23 Oct 2019 17:52:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 187A44C044;
        Wed, 23 Oct 2019 17:52:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 17:52:19 +0000 (GMT)
Subject: Re: [PATCH v1 5/6] KEYS: measure queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 13:52:19 -0400
In-Reply-To: <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-6-nramas@linux.microsoft.com>
         <1571836990.5104.96.camel@linux.ibm.com>
         <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102317-4275-0000-0000-000003764C0B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102317-4276-0000-0000-00003889740D
Message-Id: <1571853139.5104.154.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230168
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-23 at 10:34 -0700, Lakshmi Ramasubramanian wrote:
> On 10/23/19 6:23 AM, Mimi Zohar wrote:
> 
> > The ordering of this patch set is awkward.  It should first introduce
> > a generic method for measuring keys based on the keyring.  Then add
> > the additional support needed for the specific builtin_trusted_keys
> > keyring usecase.
> 
> Would the following ordering of the patch set be acceptable:
> 
>   => PATCH 0/5: Cover letter
> 
>   => PATCH 1/5: Define the enum "hook(BUILTIN_TRUSTED_KEYS)" in ima.h
> 
>   => PATCH 2/5: Define ima hook
>                 This will initially do nothing if ima is not yet
>                 initialized.
>                 Call process_buffer_measurement() if ima is initialized.
> 
>   => PATCH 3/5: key_create_or_update change and the call to ima hook
> 
>   => PATCH 4/5: Queue\De-Queue of key measurement requests.
>                 Enable queuing of key in the ima hook if ima is not
>                 initialized.
> 
>   => PATCH 5/5: ima policy to enable measurement of keys which will
>                 enable end-to-end working of this feature.

The first patches need to introduce the generic concept of measuring
keys based on policy.  Only afterwards would you add any builtin
trusted keyring specific code.

Mimi

