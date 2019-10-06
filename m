Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505D8CD202
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Oct 2019 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfJFNSB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Oct 2019 09:18:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbfJFNSB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Oct 2019 09:18:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x96DH9Ns137434
        for <linux-integrity@vger.kernel.org>; Sun, 6 Oct 2019 09:18:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vf85ktj1m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 06 Oct 2019 09:17:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 6 Oct 2019 14:17:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 6 Oct 2019 14:17:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x96DHrMb55508994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Oct 2019 13:17:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB5B911C04A;
        Sun,  6 Oct 2019 13:17:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C73F11C058;
        Sun,  6 Oct 2019 13:17:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.176.169])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Oct 2019 13:17:52 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Sun, 06 Oct 2019 09:17:51 -0400
In-Reply-To: <382dfa7b-a5f9-01e3-0624-9ecd526557bb@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
         <1567190507.10024.134.camel@linux.ibm.com>
         <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
         <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
         <1568913178.4733.89.camel@linux.ibm.com>
         <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
         <1570219032.5046.101.camel@linux.ibm.com>
         <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
         <1570226287.5046.114.camel@linux.ibm.com>
         <382dfa7b-a5f9-01e3-0624-9ecd526557bb@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100613-0020-0000-0000-0000037584C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100613-0021-0000-0000-000021CB986E
Message-Id: <1570367871.5046.161.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910060134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-04 at 17:10 -0700, Lakshmi Ramasubramanian wrote:
> On 10/4/19 2:58 PM, Mimi Zohar wrote:
> 
> > The measurements could be added to an IMA pending measurement
> > workqueue, until the TPM is enabled, assuming there is a TPM, and then
> > processed.  All of this code would be within IMA.
> 
> Good point. I will look into this.
> 
> >> I prefer gathering data on trusted keys in ima_init, but gate it by IMA
> >> policy and follow the other coding guidelines you have suggested earlier
> >> (similar to the approach taken for kexec_cmdline measurement).
> > 
> > So your intention is only to measure the initial keys added to these
> > keyrings, not anything subsequently added to the secondary keyring?
> 
> I am currently measuring only the initial keys. But I think including 
> the ones added subsequently is a good idea.
> 
> > Defining an LSM/IMA hook to measure keys, based on policy, seems
> > cleaner and more useful.
> 
> I agree.

As defining an early IMA workqueue and measuring keys are independent
of each other, they should be posted, reviewed, and upstreamed as
separate patch sets.

Mimi

