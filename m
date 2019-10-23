Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F18E2154
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJWRDg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 13:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfJWRDe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 13:03:34 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NH2TBi113100
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 13:03:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vt293jyqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 13:03:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 18:03:29 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 18:03:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NH3OYv45678840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 17:03:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2ACD5205F;
        Wed, 23 Oct 2019 17:03:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6FCEE52051;
        Wed, 23 Oct 2019 17:03:22 +0000 (GMT)
Subject: Re: [PATCH v1 3/6] KEYS: ima hook to measure builtin_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 13:03:21 -0400
In-Reply-To: <6a3f2efa-fc05-7bfd-368a-910dd4525f4c@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-4-nramas@linux.microsoft.com>
         <1571836931.5104.95.camel@linux.ibm.com>
         <6a3f2efa-fc05-7bfd-368a-910dd4525f4c@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102317-0008-0000-0000-0000032637FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102317-0009-0000-0000-00004A45683A
Message-Id: <1571850201.5104.149.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230163
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-10-23 at 07:49 -0700, Lakshmi Ramasubramanian wrote:
> On 10/23/19 6:22 AM, Mimi Zohar wrote:
> 
> Thanks for reviewing the changes Mimi.
> I'll address your comments and post an updated patch set shortly.
> 
> >> Add a new ima hook to measure keys added to builtin_trusted_keys
> >> keyring.
> > 
> > There is no IMA hook in this patch.
> > 
> 
> >> +			else if (strcmp(args[0].from,
> >> +					"BUILTIN_TRUSTED_KEYS") == 0)
> >> +				entry->func = BUILTIN_TRUSTED_KEYS;
> >>   			else
> >>   				result = -EINVAL;
> >>   			if (!result)
> > 
> > Any new options need to be displayed as well.
> 
> Not that I can think of. Please correct me if I am wrong.

True, since you're hard coding the policy.

