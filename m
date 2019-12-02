Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DFA10EFD4
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfLBTLo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 14:11:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727977AbfLBTLl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 14:11:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2J8FXo131186
        for <linux-integrity@vger.kernel.org>; Mon, 2 Dec 2019 14:11:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wn3pcnt0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 14:11:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Dec 2019 19:11:37 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 19:11:33 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2JBWRW40567084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 19:11:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29B8A4053;
        Mon,  2 Dec 2019 19:11:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1A92A405D;
        Mon,  2 Dec 2019 19:11:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 19:11:31 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 02 Dec 2019 14:11:31 -0500
In-Reply-To: <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
         <20191127025212.3077-2-nramas@linux.microsoft.com>
         <1574887137.4793.346.camel@linux.ibm.com>
         <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
         <1575309622.4793.413.camel@linux.ibm.com>
         <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120219-0012-0000-0000-0000036FDE17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120219-0013-0000-0000-000021AB9755
Message-Id: <1575313891.4793.423.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_04:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020163
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-02 at 10:39 -0800, Lakshmi Ramasubramanian wrote:
> On 12/2/19 10:00 AM, Mimi Zohar wrote:
> 
> > 
> > ima_update_policy() is called from multiple places.  Initially, it is
> > called before a custom policy has been loaded.  The call to
> > ima_process_queued_keys_for_measurement() needs to be moved to within
> > the test, otherwise it runs the risk of dropping "key" measurements.
> 
> static const struct file_operations ima_measure_policy_ops = {
> 	.release = ima_release_policy,
> };
> 
> ima_update_policy() is called from ima_release_policy() function.
> 
> On my test machine I have the IMA policy in /etc/ima/ima-policy file. 
> When IMA policy is setup from this file, I see ima_release_policy() 
> called (which in turn calls ima_update_policy()).
> 
> How can I have ima_update_policy() called before a custom policy is loaded?

Oops, you're right.  My concern was ima_init_policy(), but it calls
ima_update_policy_flag() directly.

Mimi

