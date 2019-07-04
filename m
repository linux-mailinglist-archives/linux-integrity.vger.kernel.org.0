Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7D5F78E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfGDL70 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 07:59:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727590AbfGDL70 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 07:59:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64Bvv1k046272
        for <linux-integrity@vger.kernel.org>; Thu, 4 Jul 2019 07:59:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thf08vu3y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 07:59:25 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Jul 2019 12:59:24 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 12:59:21 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64Bx8LP37683492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 11:59:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DCE452051;
        Thu,  4 Jul 2019 11:59:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.72])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5EC895204E;
        Thu,  4 Jul 2019 11:59:18 +0000 (GMT)
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Date:   Thu, 04 Jul 2019 07:59:07 -0400
In-Reply-To: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070411-0020-0000-0000-00000350382D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070411-0021-0000-0000-000021A3D4D8
Message-Id: <1562241547.6165.81.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-03 at 23:32 -0400, Nayna Jain wrote:
> The nr_allocated_banks and allocated banks are initialized as part of
> tpm_chip_register. Currently, this is done as part of auto startup
> function. However, some drivers, like the ibm vtpm driver, do not run
> auto startup during initialization. This results in uninitialized memory
> issue and causes a kernel panic during boot.
> 
> This patch moves the pcr allocation outside the auto startup function
> into tpm_chip_register. This ensures that allocated banks are initialized
> in any case.
> 
> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> PCR read")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

