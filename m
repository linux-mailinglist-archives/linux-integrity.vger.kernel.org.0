Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259CB11E455
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 14:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLMNG5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 08:06:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbfLMNG5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 08:06:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDD6Ba6111213
        for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2019 08:06:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxseb39-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2019 08:06:55 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 13 Dec 2019 13:06:53 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Dec 2019 13:06:49 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBDD66Yh22282504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 13:06:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E840A4066;
        Fri, 13 Dec 2019 13:06:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 596ABA4054;
        Fri, 13 Dec 2019 13:06:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.131.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Dec 2019 13:06:47 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 13 Dec 2019 08:06:46 -0500
In-Reply-To: <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
         <20191213004250.21132-2-nramas@linux.microsoft.com>
         <1576202134.4579.189.camel@linux.ibm.com>
         <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
         <1576204377.4579.206.camel@linux.ibm.com>
         <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121313-0028-0000-0000-000003C82E99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121313-0029-0000-0000-0000248B6C03
Message-Id: <1576242406.4579.239.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130105
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 18:59 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/2019 6:32 PM, Mimi Zohar wrote:
> 
> >>>
> >>> Don't you need a test here, before setting ima_process_keys?
> >>>
> >>> 	if (ima_process_keys)
> >>> 		return;

> >> That check is done before the comment - at the start of
> >> ima_process_queued_keys().
> > 
> > The first test prevents taking the mutex unnecessarily.
> > 
> 
> I am trying to understand your concern here. Could you please clarify?
> 
>   => If ima_process_keys is false
>        -> With the mutex held, should check ima_process_keys again 
> before setting?
> 
> Let's say 2 or more threads are racing in calling ima_process_queued_keys():
> 
> The 1st one will set ima_process_keys and process queued keys.
> 
> The 2nd and subsequent ones - even if they have gone past the initial 
> check, will find an empty list of keys (the list "ima_keys") when they 
> take the mutex. So they'll not process any keys.

I just need to convince myself that this is correct.  Normally before
reading and writing a flag, there is some sort of locking.  With
taking the mutex before setting the flag, there is now only a lock
around the single writer.

Without taking a lock before reading the flag, will the queue always
be empty is the question.  If it is, then the comment is correct, but
the code assumes not and processes the list again.  Testing the flag
after taking the mutex just re-enforces the comment.

Bottom line, does reading the flag need to be lock protected?

Mimi


