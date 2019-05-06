Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCDA1495D
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFMNU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 08:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbfEFMNU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 08:13:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46C1sNC054305
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 08:13:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sajd2nu77-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 08:13:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 13:13:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 13:13:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46CDBJI59899906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 12:13:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC37AE053;
        Mon,  6 May 2019 12:13:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98BCAAE045;
        Mon,  6 May 2019 12:13:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.145])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 12:13:10 +0000 (GMT)
Subject: Re: [PATCH 0/5 v4] Kexec cmdline bufffer measure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com,
        nramas@microsoft.com, prsriva@microsoft.com
Date:   Mon, 06 May 2019 08:12:59 -0400
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050612-0020-0000-0000-00000339CBA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050612-0021-0000-0000-0000218C6061
Message-Id: <1557144779.14288.92.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-03 at 15:25 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> For Kexec scenario(kexec_file_load) cmdline args are passed to the
> next kerenel. These cmldine args used to load the next kernel can 
> have undesired/unwanted configs. To guard against any unwanted cmdline
> args being passed to the next kernel. The current kernel should measure
> the cmdline args to the next kernel, the same takes place in the EFI
> bootloader. Thus on kexec the boot_aggregate does not change.

The boot command line is calculated and added to the current running
kernel's measurement list.  On a soft reboot like kexec, the PCRs are
not reset to zero.  Refer to commit 94c3aac567a9 ("ima: on soft
reboot, restore the measurement list") patch description.

> Currently the cmdline args are not measured, this changeset adds a new
> ima and LSM hook for buffer measure and calls into the same to measure
> the cmdline args passed to the next kernel.The cdmline args meassured
> can then be used as an attestation criteria.

Please update this paragraph to reflect the current patch set. 

> 
> The ima logs need to injected into the next kernel, which will be followed
> up by other patchsets.

The log isn't "injected" into the next kernel, but needs to be carried
over, as described in the above referenced commit.

Mimi

