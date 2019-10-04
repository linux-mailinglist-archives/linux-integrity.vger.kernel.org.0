Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27B2CC3D8
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfJDT5V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 15:57:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729079AbfJDT5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 15:57:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94JvGo7083569
        for <linux-integrity@vger.kernel.org>; Fri, 4 Oct 2019 15:57:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ve9p66ud1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 04 Oct 2019 15:57:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 4 Oct 2019 20:57:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Oct 2019 20:57:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x94JvDMU46662026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 19:57:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FB155204F;
        Fri,  4 Oct 2019 19:57:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8673A5204E;
        Fri,  4 Oct 2019 19:57:12 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Fri, 04 Oct 2019 15:57:12 -0400
In-Reply-To: <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
         <1567190507.10024.134.camel@linux.ibm.com>
         <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
         <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
         <1568913178.4733.89.camel@linux.ibm.com>
         <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100419-0016-0000-0000-000002B41E1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100419-0017-0000-0000-000033152F55
Message-Id: <1570219032.5046.101.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-04 at 12:29 -0700, Lakshmi Ramasubramanian wrote:
> On 9/19/19 10:12 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> > On 9/1 I commented on this patch set from a technical perspective,
> > saying: >
> > IMA measures, appraises, and audits files based on policy[1].  If
> > you're going to measure keys, all of the code should be within the IMA
> > subdirectory.  The only code outside of the IMA subdirectory is either
> > an LSM or IMA hook.  If an LSM hook already exists, use it.  If an LSM
> > hook doesn't exist and the location is generic that other LSMs would
> > be interested, define a new LSM hook, otherwise define a new IMA hook.
> 
> I am having trouble addressing the above feedback. Appreciate if you 
> could provide guidance:
> 
> The key(s) in the trusted keys keyring (builtin, secondary, etc.) are 
> added early in the kernel boot process. But IMA is initialized later.
> If I have a LSM\IMA hook, that gets called when key(s) are added to the 
> trusted keys keyring, I won't be able to invoke IMA on "key add" since 
> IMA is not yet initialized.
> 
> Right now, I have the key measurement function in ima_init. I can gate 
> that based on policy (similar to how Prakhar has done kexec_cmdline 
> measurement) and follow the coding guidelines you have pointed to.
> But it would still have to call keyring function to get the list of keys 
> in the trusted keys keyring.
> 
> Are you fine if I take the above approach?
> 
> If not, could you please suggest a better way to handle it that meets 
> the kernel layering guidelines?

IMA is late because it is waiting for the TPM to be available.
 Another option would be to queue the measurements and then replay
them once the TPM and IMA are available.

I'm not sure I like this approach any better.

Mimi

