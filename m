Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8372DF97E7
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLR6p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:58:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34676 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfKLR6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:58:43 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACHrUlR183213
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:58:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7qdc26t7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:58:38 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:58:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:58:32 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACHvtDQ38470082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:57:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B9042041;
        Tue, 12 Nov 2019 17:58:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D73ED4203F;
        Tue, 12 Nov 2019 17:58:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:58:29 +0000 (GMT)
Subject: Re: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to
 only measure keys added to the specified keyrings.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 12:58:29 -0500
In-Reply-To: <1f940f9d-fb1b-a0a4-b5f4-3f3532dbc041@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-3-nramas@linux.microsoft.com>
         <1573578305.17949.42.camel@linux.ibm.com>
         <1f940f9d-fb1b-a0a4-b5f4-3f3532dbc041@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0028-0000-0000-000003B64F9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0029-0000-0000-000024795461
Message-Id: <1573581509.17949.57.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120153
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-12 at 09:43 -0800, Lakshmi Ramasubramanian wrote:
> On 11/12/2019 9:05 AM, Mimi Zohar wrote:
> 
> > The C maximum line length is 80 characters.  The subject line is even
> > less than that (~50).  The Subject line here could be "ima: add
> > support to limit measuring keys".
> I'll update the subject line for the patches - limit to max 50 chars.
> 
> > 
> > On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
> >> IMA policy needs to support measuring only those keys linked to
> >> a specific set of keyrings.
> > 
> > Patch descriptions should be written in the imperative.  For example,
> > "Limit measuring keys to those keys being loaded onto a specific
> > keyring."
> Will update.
> 
> > 
> >>
> >> This patch defines a new IMA policy option namely "keyrings=" that
> >> can be used to specify a set of keyrings. If this option is specified
> >> in the policy for func=KEYRING_CHECK then only the keys linked to
> >> the keyrings given in "keyrings=" option are measured.
> > 
> > This description does not seem to match the code, which for some
> > reason isn't included in this patch, nor in 3/10.  Please
> > combine/squash patches 2 & 3.  Missing from the combined patch is the
> > keyring matching code in ima_match_rules().
> 
> This patch defines "keyrings=" option in the IMA policy and adds the 
> related field in ima_rule_entry struct.
> 
> The code for updating the new field in ima_rule_entry is in patch #4
> [PATCH v5 04/10] IMA: Updated IMA policy functions to return keyrings 
> option read from the policy

That's the problem.  The keyrings doesn't need to be returned, but
processed in ima_match_rules().

Mimi

