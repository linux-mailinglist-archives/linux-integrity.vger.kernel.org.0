Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4F119FBD
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLKAD2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 19:03:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfLKAD2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 19:03:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBB02E6T115035
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 19:03:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtdp3kbvj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 19:03:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Dec 2019 00:03:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Dec 2019 00:03:21 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBB03KaJ45482106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 00:03:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EF4711C054;
        Wed, 11 Dec 2019 00:03:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CAA011C04C;
        Wed, 11 Dec 2019 00:03:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Dec 2019 00:03:18 +0000 (GMT)
Subject: Re: [PATCH v10 1/6] IMA: Check IMA policy flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 19:03:18 -0500
In-Reply-To: <6385347a-bc40-7717-f9ad-8ed7dd7fee51@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-2-nramas@linux.microsoft.com>
         <1576017749.4579.40.camel@linux.ibm.com>
         <6385347a-bc40-7717-f9ad-8ed7dd7fee51@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121100-0028-0000-0000-000003C75B93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121100-0029-0000-0000-0000248A8D76
Message-Id: <1576022598.4579.50.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_08:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100197
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 15:29 -0800, Lakshmi Ramasubramanian wrote:
> On 12/10/19 2:42 PM, Mimi Zohar wrote:
> 
> > Patch descriptions aren't suppose to be written as pseudo code.  Start
> > with the current status and problem description.
> > 
> > For example, "process_buffer_measurement() may be called prior to IMA being initialized, which would result in a kernel panic.  This patch ..."
> > 
> > Mimi
> 
> I'll update the patch description in this one and in the other patches 
> per your comments.
> 
> Are you done reviewing all the patches in this set?
> 
> Other than the one code change per your comment on "[PATCH v10 5/6]" 
> there are no other code changes I need to make?
> Just wanted to confirm.
> 
> 	[PATCH v10 5/6] IMA: Add support to limit measuring keys
> => With the additional "uid" support this isn't necessarily true any
> more.

Yes, other than the code change needed for this and the patch
descriptions, it looks good.  Am continuing with reviewing the other
patch set - queueing "key" measurements.

Mimi

