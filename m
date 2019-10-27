Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645E3E637B
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Oct 2019 15:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfJ0Ord (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Oct 2019 10:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbfJ0Ord (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 10:47:33 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9REkcvf029249
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 10:47:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vvhss48k2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 10:47:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 27 Oct 2019 14:47:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 27 Oct 2019 14:47:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9RElQtk38797364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Oct 2019 14:47:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7EF9A4053;
        Sun, 27 Oct 2019 14:47:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C07AEA4040;
        Sun, 27 Oct 2019 14:47:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.187.251])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 27 Oct 2019 14:47:24 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on
 key create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Sun, 27 Oct 2019 10:47:24 -0400
In-Reply-To: <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-2-nramas@linux.microsoft.com>
         <1572032428.4532.72.camel@linux.ibm.com>
         <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102714-0008-0000-0000-0000032813FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102714-0009-0000-0000-00004A474F0A
Message-Id: <1572187644.4532.211.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910270155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-25 at 15:28 -0700, Lakshmi Ramasubramanian wrote:
> On 10/25/2019 12:40 PM, Mimi Zohar wrote:
> 
> >> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >> +				   unsigned long flags, bool create)
> >> +{
> >> +	const struct public_key *pk;
> >> +
> >> +	if (key->type != &key_type_asymmetric)
> >> +		return;
> >> +
> >> +	if (!ima_initialized)
> >> +		return;
> > 
> > There's no reason to define a new variable to determine if IMA is
> > initialized.  Use ima_policy_flag.  
> 
> Please correct me if I am wrong -
> 
> ima_policy_flag will be set to 0 if IMA is not yet initialized
> OR
> IMA is initialized, but ima_policy_flag could be still set to 0 (say, 
> due to the configured policy).
> 
> In the latter case the measurement request should be a NOP immediately.

I'm not sure.  The builtin keys most likely will be loaded prior to a
custom IMA policy containing "keyring" rules are defined.

Mimi

