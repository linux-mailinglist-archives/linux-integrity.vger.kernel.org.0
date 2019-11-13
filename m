Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FDEFB9B8
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 21:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfKMUZC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 15:25:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfKMUZC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 15:25:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADKLoIC090721
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:25:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8q18c5fj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 15:25:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Nov 2019 20:24:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 20:24:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADKOres47185922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 20:24:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A392C42049;
        Wed, 13 Nov 2019 20:24:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C02D4203F;
        Wed, 13 Nov 2019 20:24:52 +0000 (GMT)
Received: from dhcp-9-31-103-201.watson.ibm.com (unknown [9.31.103.201])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 20:24:52 +0000 (GMT)
Subject: Re: [PATCH v6 1/3] IMA: Add KEY_CHECK func to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Nov 2019 15:24:52 -0500
In-Reply-To: <320826aa-f744-f2ae-8693-a6ce9461d886@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-2-nramas@linux.microsoft.com>
         <1573676066.4843.18.camel@linux.ibm.com>
         <320826aa-f744-f2ae-8693-a6ce9461d886@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111320-0012-0000-0000-000003636213
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111320-0013-0000-0000-0000219ED864
Message-Id: <1573676692.4843.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130167
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 12:21 -0800, Lakshmi Ramasubramanian wrote:
> On 11/13/2019 12:14 PM, Mimi Zohar wrote:
> 
> >> @@ -655,6 +655,13 @@ void process_buffer_measurement(const void *buf, int size,
> >>   	int action = 0;
> >>   	u32 secid;
> >>   
> >> +	/*
> >> +	 * If IMA is not yet initialized or IMA policy is empty
> >> +	 * then there is no need to measure.
> >> +	 */
> >> +	if (!ima_policy_flag)
> >> +		return;
> >> +
> > 
> > This addition has nothing to do with defining a new IMA hook and
> > should be a separate patch.  This can be posted independently of this
> > patch set.
> > 
> > Mimi
> 
> I'll move this change to a different patch,
> but it has to be either part of this patch set or the above change alone 
> needs to be taken before this patch set for the following reason:
> 
> The IMA hook gets called early in the boot process (for example, when 
> builtin_trusted_keys are added). If the above check is not there, 
> ima_get_action() is called and causes kernel panic (since IMA is not yet 
> initialized).

It will be upstreamed prior to this patch set.
 
Mimi

