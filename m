Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6525612F9F9
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 16:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgACPsF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 10:48:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbgACPsF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 10:48:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003FjETa113671
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 10:48:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xa2cdaax2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 10:48:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Jan 2020 15:48:02 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 15:47:57 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003FlAcs48955870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 15:47:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9739AE045;
        Fri,  3 Jan 2020 15:47:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA89AE053;
        Fri,  3 Jan 2020 15:47:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.213.69])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 15:47:55 +0000 (GMT)
Subject: Re: [PATCH v6 0/3] IMA: Deferred measurement of keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 03 Jan 2020 10:47:54 -0500
In-Reply-To: <1578064099.5874.170.camel@linux.ibm.com>
References: <20200103055608.22491-1-nramas@linux.microsoft.com>
         <1578064099.5874.170.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010315-0016-0000-0000-000002DA3A69
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010315-0017-0000-0000-0000333CA818
Message-Id: <1578066474.5874.174.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-03 at 10:08 -0500, Mimi Zohar wrote:
> > This change adds support for queuing keys created or updated before
> > a custom IMA policy is loaded. The queued keys are processed when
> > a custom policy is loaded. Keys created or updated after a custom policy
> > is loaded are measured immediately (not queued).
> > 
> > If the kernel is built with both CONFIG_IMA and
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> > must be applied as a custom policy for the keys to be measured.
> > If a custom IMA policy is not provided within 5 minutes after
> > IMA is initialized, any queued keys will be freed.
> 
> As the merge message, this is too much information.  I would extend
> the previous paragraph and drop this one, like:
> "... (not queued).  In the case when a custom policy is not loaded
> within 5 minutes of IMA initialization, the queued keys are freed."
> 
> > This is by design.
> 
> It's unclear what "is by design" refers to.  Perhaps expand this
> sentence like: "Measuring the early boot keys, by design, requires
> loading a custom policy.

Instead of including this comment as the last sentence of the cover
letter, it would make a good opening sentence for the second
paragraph.

Mimi

