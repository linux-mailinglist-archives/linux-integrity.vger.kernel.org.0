Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5FA10EED8
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLBSAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:00:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbfLBSAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:00:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2HvqP0070070
        for <linux-integrity@vger.kernel.org>; Mon, 2 Dec 2019 13:00:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g8rqvr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 13:00:33 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Dec 2019 18:00:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 18:00:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2I0Pv657737372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 18:00:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CFC1A4055;
        Mon,  2 Dec 2019 18:00:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69042A4051;
        Mon,  2 Dec 2019 18:00:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 18:00:23 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 02 Dec 2019 13:00:22 -0500
In-Reply-To: <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
         <1574887137.4793.346.camel@linux.ibm.com>
         <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120218-0008-0000-0000-0000033BD2C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120218-0009-0000-0000-00004A5AEA58
Message-Id: <1575309622.4793.413.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_04:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=939 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-27 at 13:11 -0800, Lakshmi Ramasubramanian wrote:
> On 11/27/19 12:38 PM, Mimi Zohar wrote:

> > I'm not sure why you want to differentiate between IMA being
> > initialized vs. an empty policy.  I would think you would want to know
> > when a custom policy has been loaded.
> 
> You are right - When custom ima policy rules are loaded (in 
> ima_update_policy() function), ima_process_queued_keys_for_measurement() 
> function is called to process queued keys.
> 
> The flag ima_process_keys_for_measurement is set to true in 
> ima_process_queued_keys_for_measurement(). And, subsequent keys are 
> processed immediately.
> 
> Please take a look at ima_process_queued_keys_for_measurement() in this 
> patch (v0 1/2) and the ima_update_policy() change in "PATCH v0 2/2".

ima_update_policy() is called from multiple places.  Initially, it is
called before a custom policy has been loaded.  The call to
ima_process_queued_keys_for_measurement() needs to be moved to within 
the test, otherwise it runs the risk of dropping "key" measurements.

All the queued keys need to be processed at the same time.  Afterwards
the queue should be deleted.  Unfortunately, the current queue locking
assumes ima_process_queued_keys_for_measurement() is called multiple
times.

Perhaps using the RCU method of walking lists would help.  I need to
think about it some more.

Mimi

