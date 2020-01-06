Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C141312C3
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFNXo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 08:23:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgAFNXo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 08:23:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006DMn9r111704
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 08:23:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb94y23bp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 08:23:43 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 Jan 2020 13:23:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 13:23:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006DNbfN45613298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 13:23:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C4152050;
        Mon,  6 Jan 2020 13:23:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.222])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 96C1B52052;
        Mon,  6 Jan 2020 13:23:36 +0000 (GMT)
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 06 Jan 2020 08:23:36 -0500
In-Reply-To: <dd99db8f-08de-d7ac-3d63-0717fc6c7ba5@linux.microsoft.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
         <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
         <1578248115.3310.41.camel@HansenPartnership.com>
         <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
         <1578251768.3310.49.camel@HansenPartnership.com>
         <dd99db8f-08de-d7ac-3d63-0717fc6c7ba5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010613-0008-0000-0000-00000346E718
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010613-0009-0000-0000-00004A67259D
Message-Id: <1578317016.5222.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-01-05 at 19:58 -0800, Lakshmi Ramasubramanian wrote:
> On 1/5/20 11:16 AM, James Bottomley wrote:
> 
> > Well, yes, you just need to condition the build of ima_asymmetric_keys
> > on a boolean instead of a tristate, so you introduce an intermediate
> > one:
> > 
> > config IMA_ASYMMETRIC_KEYS
> > 	bool
> > 	default y
> > 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > 
> > James
> 
> Thanks for your help James.
> 
> Hi Mimi,
> 
> I have defined a new config as James has suggested above and verified 
> the kernel builds fine with the ".config" files given by
> "kbuild test robot <lkp@intel.com>".
> 
> Would it be possible to share all the ".config" files that
> "kbuild test robot" would build with? I'll make sure my changes build 
> fine with all those.

Different groups are doing automatic testing.  This one is coming from
Intel's kbuild test robot, but there is syzbot and smatch testing as
well.  Your question would need to be directed to them.

Mimi

