Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72E44D47
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfFMUUX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 16:20:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727668AbfFMUUW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 16:20:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DKHC86143759
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:20:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3td0qd48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:20:21 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Jun 2019 21:20:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 21:20:17 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DKKGfC60358732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 20:20:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3571442045;
        Thu, 13 Jun 2019 20:20:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5403F42047;
        Thu, 13 Jun 2019 20:20:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.91])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 20:20:15 +0000 (GMT)
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline
 args
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Thu, 13 Jun 2019 16:20:04 -0400
In-Reply-To: <20190612221549.28399-4-prsriva02@gmail.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-4-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061320-0020-0000-0000-00000349E6E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061320-0021-0000-0000-0000219D1FB0
Message-Id: <1560457204.4805.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> During soft reboot(kexec_file_load) boot cmdline args

Any reason for not spelling it out and using the "boot command line"?

> are not measured.Thus the new kernel on load boots with
> an assumption of cold reboot.

Double spaces after a period.

What does "boots with an assumption of cold reboot" mean?  Not all
systems are booted the same way.  Is this comment relevant?

> 
> This patch makes a call to the ima hook ima_kexec_cmdline,
> added in "Define a new IMA hook to measure the boot command
> line arguments"

"added in ..." is unnecessry.

> to measure the boot cmdline args into the ima log.

^IMA measurement list.

Mimi

