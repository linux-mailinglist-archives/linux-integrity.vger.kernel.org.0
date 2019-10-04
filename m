Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD0CC580
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfJDV6S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 17:58:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730770AbfJDV6R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 17:58:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94Luw0l056098
        for <linux-integrity@vger.kernel.org>; Fri, 4 Oct 2019 17:58:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vedef9sjp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 04 Oct 2019 17:58:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 4 Oct 2019 22:58:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Oct 2019 22:58:09 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x94Lw84D47710448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 21:58:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6356AE045;
        Fri,  4 Oct 2019 21:58:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4E70AE055;
        Fri,  4 Oct 2019 21:58:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Oct 2019 21:58:07 +0000 (GMT)
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
Date:   Fri, 04 Oct 2019 17:58:07 -0400
In-Reply-To: <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
         <1567190507.10024.134.camel@linux.ibm.com>
         <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
         <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
         <1568913178.4733.89.camel@linux.ibm.com>
         <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
         <1570219032.5046.101.camel@linux.ibm.com>
         <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100421-0008-0000-0000-0000031E1F1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100421-0009-0000-0000-00004A3D2BB9
Message-Id: <1570226287.5046.114.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040183
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-04 at 13:10 -0700, Lakshmi Ramasubramanian wrote:
> On 10/4/19 12:57 PM, Mimi Zohar wrote:
> 
> > 
> > IMA is late because it is waiting for the TPM to be available.
>  >
> > Another option would be to queue the measurements and then replay
> > them once the TPM and IMA are available.
> > 
> > I'm not sure I like this approach any better.
> 
> I agree - I too don't like this approach (queue the measurements and 
> then replay). Even in that approach IMA will have to invoke functions 
> outside of IMA to retrieve the stored measurements.

The measurements could be added to an IMA pending measurement
workqueue, until the TPM is enabled, assuming there is a TPM, and then
processed.  All of this code would be within IMA.

> 
> I prefer gathering data on trusted keys in ima_init, but gate it by IMA 
> policy and follow the other coding guidelines you have suggested earlier 
> (similar to the approach taken for kexec_cmdline measurement).

So your intention is only to measure the initial keys added to these
keyrings, not anything subsequently added to the secondary keyring?

> Please let me know if you agree - I can send the new patch set by next week.

Defining an LSM/IMA hook to measure keys, based on policy, seems
cleaner and more useful.

Mimi

