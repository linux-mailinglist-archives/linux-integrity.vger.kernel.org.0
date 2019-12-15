Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E111F7C5
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Dec 2019 13:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOMor (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Dec 2019 07:44:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfLOMoq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Dec 2019 07:44:46 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBFCgPlW131518
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 07:44:45 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdxx2kb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 07:44:45 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 15 Dec 2019 12:44:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 15 Dec 2019 12:44:40 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBFCidZk49348706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Dec 2019 12:44:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC9B42041;
        Sun, 15 Dec 2019 12:44:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C3DA4203F;
        Sun, 15 Dec 2019 12:44:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.206.32])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 15 Dec 2019 12:44:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Sun, 15 Dec 2019 07:44:37 -0500
In-Reply-To: <1576242406.4579.239.camel@linux.ibm.com>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
         <20191213004250.21132-2-nramas@linux.microsoft.com>
         <1576202134.4579.189.camel@linux.ibm.com>
         <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
         <1576204377.4579.206.camel@linux.ibm.com>
         <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
         <1576242406.4579.239.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121512-0012-0000-0000-00000375088F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121512-0013-0000-0000-000021B0EB8C
Message-Id: <1576413877.4579.280.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-15_03:2019-12-13,2019-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912150121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-13 at 08:06 -0500, Mimi Zohar wrote:
> On Thu, 2019-12-12 at 18:59 -0800, Lakshmi Ramasubramanian wrote:
> > On 12/12/2019 6:32 PM, Mimi Zohar wrote:
> > 
> > >>>
> > >>> Don't you need a test here, before setting ima_process_keys?
> > >>>
> > >>> 	if (ima_process_keys)
> > >>> 		return;
> 
> > >> That check is done before the comment - at the start of
> > >> ima_process_queued_keys().
> > > 
> > > The first test prevents taking the mutex unnecessarily.
> > > 
> > 
> > I am trying to understand your concern here. Could you please clarify?
> > 
> >   => If ima_process_keys is false
> >        -> With the mutex held, should check ima_process_keys again 
> > before setting?
> > 
> > Let's say 2 or more threads are racing in calling ima_process_queued_keys():
> > 
> > The 1st one will set ima_process_keys and process queued keys.
> > 
> > The 2nd and subsequent ones - even if they have gone past the initial 
> > check, will find an empty list of keys (the list "ima_keys") when they 
> > take the mutex. So they'll not process any keys.
> 
> I just need to convince myself that this is correct.  Normally before
> reading and writing a flag, there is some sort of locking.  With
> taking the mutex before setting the flag, there is now only a lock
> around the single writer.
> 
> Without taking a lock before reading the flag, will the queue always
> be empty is the question.  If it is, then the comment is correct, but
> the code assumes not and processes the list again.  Testing the flag
> after taking the mutex just re-enforces the comment.
> 
> Bottom line, does reading the flag need to be lock protected?

Reading the flag IS lock protected, just spread across two functions.
 For performance, ima_post_key_create_or_update() checks
ima_process_keys, before calling ima_queue_key(), which takes the
mutex before checking ima_process_keys again.

As long as both the reader and writer, take the mutex before checking
the flag, the locking is fine.  The additional check, before taking
the mutex, is simply for performance.

Mimi



 


