Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC842ED340
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAGPKy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 10:10:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbhAGPKy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 10:10:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 107F66j0063772;
        Thu, 7 Jan 2021 10:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y58kjMyHwOCgCgW6y39MrTDIgCok9s904NOvAJKItMI=;
 b=UZHdUbpw1RIi8NV4JOCOJ/fUb78B/vy4KrJW76qoYxa15Cn2vWqtD2QHwLfC9mDXStk2
 /x6Emo4xsAELrFIedoe9mP7V833DyC9JtIs8OjBxVCZ3SWPkELvLHKkxBS+ELDzQby2z
 1dvv7GpFDWs+DODSqiIoeanUN448XYOkISIv5BfJMgMJnuim0MbSzLlvVt5BW26+ZduB
 WnHziVPDz+KGnhQCpLylzKVlX+UUPTirAvT7hjNnOVuOzh0lL0H6UvekBR/veA50Yetl
 UjMB5X0SQz8uS62tzrCw/SUTR6bW4QUdxnLTkRTdPs4Hfyxf+DebDcOAtHFrL702oQ4e bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x3pt2403-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 10:10:11 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 107F6OWQ065019;
        Thu, 7 Jan 2021 10:07:53 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35x3pt1t8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 10:07:53 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 107F27wp005427;
        Thu, 7 Jan 2021 15:06:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 35tgf8ak15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jan 2021 15:06:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 107F6UXC25821574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jan 2021 15:06:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59113AE061;
        Thu,  7 Jan 2021 15:06:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BC4FAE04D;
        Thu,  7 Jan 2021 15:06:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.37.241])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jan 2021 15:06:32 +0000 (GMT)
Message-ID: <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 07 Jan 2021 10:06:31 -0500
In-Reply-To: <20210105195742.2629-1-raphgi@linux.microsoft.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-07_07:2021-01-07,2021-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070091
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: Amir Goldstein]

On Tue, 2021-01-05 at 11:57 -0800, Raphael Gianotti wrote:
> IMA measures files and buffer data and some systems may end up
> generating lots of entries in the IMA measurement list. This list is
> kept in kernel memoryc and as it grows in size it could end up taking
> too many resources, causing the system to run out of available
> memory. During kexec, the IMA measurement list can be carried over in
> memory, but it's possible for the list to become too large for that
> to happen.
> 
> The Kconfig introduced in this series enables admins to configure a
> maximum number of entries and a file to export the IMA measurement
> list to whenever the set limit is reached.
> 
> The list is written out in append mode, so the system will keep
> writing new entries as long as it stays running or runs out of
> space. Whenever the export file is set, it's truncated. If writing
> to the export list fails, a flag is set to prevent further exports,
> as the file is likely in a bad state. Setting a new export file
> resets this flag, allowing exports to resume and giving admins a way
> to recover from this state if necessary.
> 
> In the case of kexec, if the list is too large too be carried over in
> memory and an export file is configured, the list will be exported,
> preventing the measurements from being lost during kexec.
> 
> This code is based off of a previous RFC sent by Janne Karhunen[1],
> and is intended to pick up where that was left off.
> 
> In a thread with Janne Karhunen[2], it was mentioned that another
> approach, using mm had been considered. Upon some investigation the
> approach used in this RFC still seemed adequate for solving this
> problem.
> 
> [1] https://patchwork.kernel.org/project/linux-integrity/patch/201912
> 20074929.8191-1-janne.karhunen@gmail.com/
> [2] https://lore.kernel.org/linux-integrity/CAE=NcrbdS-3gVvnnEwdNSOLO
> vTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com/
> 
> Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>

My original concerns of truncating the IMA measurement list have not
been addressed.  Once the IMA measurement list has been truncated,
quoting and then verifying any of the PCRs contained in the measurement
list will fail, unless the measurements have been preserved and are
readily accessible.

Amir's suggestion addresses kernel memory constraints without
truncating the IMA measurement list.

Mimi

