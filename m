Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BF11D9B3
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 23:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfLLWy2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 17:54:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731212AbfLLWy2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 17:54:28 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCMsLbZ110912
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 17:54:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wusv08ky6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 17:54:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 12 Dec 2019 22:54:23 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 22:54:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCMrbVo43581744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 22:53:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A452AAE04D;
        Thu, 12 Dec 2019 22:54:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB85AE045;
        Thu, 12 Dec 2019 22:54:18 +0000 (GMT)
Received: from dhcp-9-31-102-17.watson.ibm.com (unknown [9.31.102.17])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 22:54:18 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 12 Dec 2019 17:54:18 -0500
In-Reply-To: <b4ff3607-076e-7b90-24d1-9a129d9ce720@linux.microsoft.com>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
         <20191211185116.2740-2-nramas@linux.microsoft.com>
         <1576138743.4579.147.camel@linux.ibm.com>
         <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
         <1576185189.4579.165.camel@linux.ibm.com>
         <b4ff3607-076e-7b90-24d1-9a129d9ce720@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121222-0028-0000-0000-000003C7FC54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121222-0029-0000-0000-0000248B37CD
Message-Id: <1576191258.4579.181.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=3
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120175
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 13:59 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/19 1:13 PM, Mimi Zohar wrote:
> 
> > 
> > Looking at this again, something seems off or at least the comment
> > doesn't match the code.
> > 
> >         /*
> >           * To avoid holding the mutex while processing queued keys,
> >           * transfer the queued keys with the mutex held to a temp list,
> >           * release the mutex, and then process the queued keys from
> >           * the temp list.
> >           *
> >           * Since ima_process_keys is set to true above, any new key will
> >           * be processed immediately and not queued.
> >           */
> > 
> > Setting ima_process_key before taking the lock won't prevent the race.
> >   I think you want to test ima_process_keys before taking the lock and
> > again immediately afterward taking the lock, before setting it.  Then
> > the comment would match the code.
> > 
> > Shouldn't ima_process_keys be defined as static to limit the scope to
> > this file?
> > 
> > Mimi
> > 
> 
> In IMA hook, ima_process_key is checked without lock. If it is false, 
> ima_queue_key is called. If the key was queued (by ima_queue_key()) then 
> the hook defers measurement. Else, it processes it immediately.
> 
> In ima_queue_key() function the check for ima_process_key is done after 
> taking the lock and the key queued if the flag is false.
> 
> In ima_process_keys() ima_process_key is set without lock and then the 
> queued keys are moved to a temp list after taking the lock.
> 
> I have reviewed the changes myself and also with a few of my colleagues. 
> I don't think there is a race condition. Please let me know if you do 
> see a problem.
> 
> I can move the setting of ima_process_key flag inside the lock. But 
> honestly I don't think that is necessary.
> 
> I agree that ima_process_keys should be static since it is used in this 
> file one. I'll make that change.
> 
> I can also move the setting of ima_process_key flag inside the lock 
> along with the above change.

My concern is with the last sentence "Since ima_process_keys is set to
true above, any new key will be processed immediately and not queued."
  It's unlikely, but possible, that a second process will wait for the
ima_keys_mutex.  Either we remove this sentence or move setting
ima_process_keys to after taking the lock.

Mimi 

