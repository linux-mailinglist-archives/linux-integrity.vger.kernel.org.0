Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA3234B4A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgGaSpq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54642 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387676AbgGaSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:45:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIVecD089095;
        Fri, 31 Jul 2020 14:45:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mqpr9ry8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:45:40 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIWm2i093128;
        Fri, 31 Jul 2020 14:45:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mqpr9rxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:45:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIfLHG014263;
        Fri, 31 Jul 2020 18:45:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0vng8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:45:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIjZDH50987326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:45:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBDFA405B;
        Fri, 31 Jul 2020 18:45:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E2CA405F;
        Fri, 31 Jul 2020 18:45:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 18:45:34 +0000 (GMT)
Message-ID: <13c9396fe62c1bf40175897a59ab711f36d626fa.camel@linux.ibm.com>
Subject: Re: IMA/EVM interfaces
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Date:   Fri, 31 Jul 2020 14:45:30 -0400
In-Reply-To: <425db984e96241f0a28a0b650aaa0b1d@huawei.com>
References: <bf04bf15-cddd-ce22-926a-8459c1f92779@linux.com>
         <ef2745fddaec4f859cf9852028f650df@huawei.com>
         <b3d93ebd-80a0-4aea-15ef-8bd22241e19f@linux.com>
         <425db984e96241f0a28a0b650aaa0b1d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-30 at 06:50 +0000, Roberto Sassu wrote:
> > From: Denis Efremov [mailto:efremov@linux.com]
> > Sent: Wednesday, July 29, 2020 11:59 PM
> > 
> > 
> > 
> > On 7/28/20 6:43 PM, Roberto Sassu wrote:
> > > > From: linux-integrity-owner@vger.kernel.org [mailto:linux-
> > > > integrity-
> > > > owner@vger.kernel.org] On Behalf Of Denis Efremov
> > > > Sent: Tuesday, July 28, 2020 12:32 PM
> > > > Hi,
> > > > 
> > > > I've started to add integrity interfaces descriptions to
> > > > syzkaller
> > > > (https://github.com/google/syzkaller/pull/1970).
> > > > 
> > > > I've got a question, if you don't mind:
> > > > 
> > > > If I write 2 to /sys/kernel/security/integrity/evm/evm before
> > > > loading
> > keys,
> > > > subsequent fs operations will fail with -ENOKEY.
> > > > 
> > > > $ echo 2 > /sys/kernel/security/integrity/evm/evm
> > > > $ touch test.txt
> 
> Looks good. Mimi, could you please take this patch, and if
> possible, the others in the patch set?

 Just needing to finish up the ima-evm-utils release and finish
reviewing Kees' " Introduce partial kernel_read_file() support" patchset.   Will circle back around to EVM shortly.

In the meantime, could you take a look at the syzbot "possible deadlock
in process_measurement" report.   According to Amir Goldstein, this
isn't a lock order inversion.  It just needs to be properly annotated.

thanks,

Mimi

