Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7915AF2618
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfKGDku (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 22:40:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733111AbfKGDkt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 22:40:49 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA73bJuK121911
        for <linux-integrity@vger.kernel.org>; Wed, 6 Nov 2019 22:40:48 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w48ykvpm1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Nov 2019 22:40:48 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Nov 2019 03:40:44 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 03:40:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA73edjd35323972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 03:40:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A915D11C04A;
        Thu,  7 Nov 2019 03:40:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD0211C04C;
        Thu,  7 Nov 2019 03:40:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.196.157])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 03:40:38 +0000 (GMT)
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on
 key create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Nov 2019 22:40:37 -0500
In-Reply-To: <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-2-nramas@linux.microsoft.com>
         <1573080189.5028.313.camel@linux.ibm.com>
         <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110703-0020-0000-0000-00000383445F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110703-0021-0000-0000-000021D97691
Message-Id: <1573098037.5028.325.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070035
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-06 at 16:21 -0800, Lakshmi Ramasubramanian wrote:
> On 11/6/2019 2:43 PM, Mimi Zohar wrote:
> 
> >> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >> +				   unsigned long flags, bool create)
> >> +{
> >> +	if ((keyring != NULL) && (key != NULL))
> >> +		return;
> > 
> > I would move the patch that defines the "keyring=" policy option prior
> > to this one.  Include the call to process_buffer_measurement() in this
> > patch.  A subsequent patch would add support to defer measuring the
> > key, by calling a function named something like
> > ima_queue_key_measurement().
> > 
> > Mimi
> 
> As I'd stated in the other response, I wanted to isolate all key related 
> code in a separate C file and build it if and only if all CONFIG 
> dependencies are met.

The basic measuring of keys shouldn't be any different than any other
policy rule, other than it is a key and not a file.  This is the
reason that I keep saying start out with the basics and then add
support to defer measuring keys on the trusted keyrings.

Only the queueing code needed for measuring keys on the trusted
keyrings would be in a separate file.

Mimi

