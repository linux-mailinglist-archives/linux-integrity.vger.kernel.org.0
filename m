Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F944D00
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfFMUHz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 16:07:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbfFMUHz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 16:07:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DK1mMK087464
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:07:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3tmkp993-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 16:07:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Jun 2019 21:07:52 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 21:07:48 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DK7lEX47513814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 20:07:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1CC552057;
        Thu, 13 Jun 2019 20:07:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.91])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B673A5204F;
        Thu, 13 Jun 2019 20:07:46 +0000 (GMT)
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline
 args
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        kexec <kexec@lists.infradead.org>
Date:   Thu, 13 Jun 2019 16:07:36 -0400
In-Reply-To: <20190613082627.GA30288@dhcp-128-65.nay.redhat.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-4-prsriva02@gmail.com>
         <1560378703.4578.91.camel@linux.ibm.com>
         <20190613082627.GA30288@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061320-0020-0000-0000-00000349E67B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061320-0021-0000-0000-0000219D1F3E
Message-Id: <1560456456.4805.61.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-06-13 at 16:26 +0800, Dave Young wrote:
> On 06/12/19 at 06:31pm, Mimi Zohar wrote:
> > [Cc: kexec mailing list]
> > 
> > Hi Eric, Dave,
> > 
> > On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> > > During soft reboot(kexec_file_load) boot cmdline args
> > > are not measured.Thus the new kernel on load boots with
> > > an assumption of cold reboot.
> > > 
> > > This patch makes a call to the ima hook ima_kexec_cmdline,
> > > added in "Define a new IMA hook to measure the boot command
> > > line arguments"
> > > to measure the boot cmdline args into the ima log.
> > > 
> > > - call ima_kexec_cmdline from kexec_file_load.
> > > - move the call ima_add_kexec_buffer after the cmdline
> > > args have been measured.
> > > 
> > > Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > 
> > Any chance we could get some Acks?
> 
> The ima_* is blackbox functions to me, looks like this patch is trying
> to measure kexec cmdline buffer and save in some ima logs and then add all the
> measure results including those for kernel/initrd to a kexec_buf and pass to 2nd

Right, including the new boot command line measurement.

> kernel.
> 
> It should be good and only take effect when IMA enabled. If all the
> assumptions are right:
> 
> Acked-by: Dave Young <dyoung@redhat.com>

Thanks, Dave.

