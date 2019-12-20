Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7120F1282CA
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfLTTgp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 14:36:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727422AbfLTTgp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 14:36:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKJJI1v058563
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 14:36:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0y9yjkh4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 14:36:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 20 Dec 2019 19:36:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Dec 2019 19:36:37 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBKJaaAV60620848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 19:36:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF5D511C05C;
        Fri, 20 Dec 2019 19:36:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC80A11C054;
        Fri, 20 Dec 2019 19:36:35 +0000 (GMT)
Received: from dhcp-9-31-103-79.watson.ibm.com (unknown [9.31.103.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Dec 2019 19:36:35 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:36:35 -0500
In-Reply-To: <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
         <1576868506.5241.65.camel@linux.ibm.com>
         <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122019-0020-0000-0000-0000039A55B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122019-0021-0000-0000-000021F18521
Message-Id: <1576870595.5241.83.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_05:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 suspectscore=11 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-20 at 11:25 -0800, Lakshmi Ramasubramanian wrote:
> On 12/20/2019 11:01 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> >> If the kernel is built with both CONFIG_IMA and
> >> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> >> must be applied as a custom policy. Not providing a custom policy
> >> in the above configuration would result in asymmeteric keys being queued
> >> until a custom policy is loaded. This is by design.
> > 
> > I didn't notice the "This is by design" here, referring to the memory
> > never being freed.  "This is by design" was suppose to refer to
> > requiring a custom policy for measuring keys.
> > 
> > For now, these two patches are queued in the next-integrity-testing
> > branch, but I would appreciate your addressing not freeing the memory
> > associated with the keys, if a custom policy is not loaded.
> > 
> > Please note that I truncated the 2/2 patch description, as it repeats
> > the existing verification example in commit ("2b60c0ecedf8 IMA: Read
> > keyrings= option from the IMA policy").
> > 
> > thanks,
> > 
> > Mimi
> > 
> 
> Sure - I am fine with truncating the 2/2 patch description. Thanks for 
> doing that.
> 
> Regarding "Freeing the queued keys if custom policy is not loaded":
> 
> Shall I create a new patch set to address that and have that be reviewed 
> independent of this patch set?

If it is just a single additional patch, feel free to post it without
a cover letter.

> 
> Like you'd suggested earlier, we can wait for a certain time, after IMA 
> is initialized, and free the queue if a custom policy was not loaded.

Different types of systems vary in boot time, but perhaps a certain
amount of time after IMA is initialized would be consistent.  This
would need to work for IoT devices/sensors to servers.

Mimi 

