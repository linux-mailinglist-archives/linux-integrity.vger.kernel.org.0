Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923C7E22BC
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404072AbfJWStf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 14:49:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404028AbfJWStf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 14:49:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NIlVix014098
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 14:49:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtt2m5dmw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 14:49:33 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 19:49:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 19:49:28 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NInRD459506866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 18:49:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5014842049;
        Wed, 23 Oct 2019 18:49:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C45A42042;
        Wed, 23 Oct 2019 18:49:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 18:49:25 +0000 (GMT)
Subject: Re: [PATCH v1 5/6] KEYS: measure queued keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 14:49:25 -0400
In-Reply-To: <1571853139.5104.154.camel@linux.ibm.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-6-nramas@linux.microsoft.com>
         <1571836990.5104.96.camel@linux.ibm.com>
         <89d778d1-1ac9-4a58-b159-7db68b7fa4ad@linux.microsoft.com>
         <1571853139.5104.154.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102318-0016-0000-0000-000002BC4B8E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102318-0017-0000-0000-0000331D8CDD
Message-Id: <1571856565.5104.176.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-23 at 13:52 -0400, Mimi Zohar wrote:
> On Wed, 2019-10-23 at 10:34 -0700, Lakshmi Ramasubramanian wrote:
> > On 10/23/19 6:23 AM, Mimi Zohar wrote:
> > 
> > > The ordering of this patch set is awkward.  It should first introduce
> > > a generic method for measuring keys based on the keyring.  Then add
> > > the additional support needed for the specific builtin_trusted_keys
> > > keyring usecase.
> > 
> > Would the following ordering of the patch set be acceptable:
> > 
> >   => PATCH 0/5: Cover letter
> > 
> >   => PATCH 1/5: Define the enum "hook(BUILTIN_TRUSTED_KEYS)" in ima.h
> > 
> >   => PATCH 2/5: Define ima hook
> >                 This will initially do nothing if ima is not yet
> >                 initialized.
> >                 Call process_buffer_measurement() if ima is initialized.
> > 
> >   => PATCH 3/5: key_create_or_update change and the call to ima hook
> > 
> >   => PATCH 4/5: Queue\De-Queue of key measurement requests.
> >                 Enable queuing of key in the ima hook if ima is not
> >                 initialized.
> > 
> >   => PATCH 5/5: ima policy to enable measurement of keys which will
> >                 enable end-to-end working of this feature.
> 
> The first patches need to introduce the generic concept of measuring
> keys based on policy.  Only afterwards would you add any builtin
> trusted keyring specific code.

1. Extend the IMA policy language to support identifying keyrings
2. Define a new IMA hook which calls process_buffer_measurement()
3. Call the new IMA hook (eg. from post_key_create_or_update)
4. Define an early workqueue for saving keys loaded prior to IMA is
initialized.  (Remember we don't hard code policy in the kernel.)

I'll be pushing out linux-integrity shortly.  For the time being,
please base your patches on -rc3.

thanks,

Mimi

