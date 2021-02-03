Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4724930D096
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 02:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBCBDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 20:03:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50004 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229959AbhBCBDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 20:03:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11311mQL182108;
        Tue, 2 Feb 2021 20:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SdTGE1PXwbqtlyGJPJvZIfLdihEWZ2Ww9GvaH4mBOts=;
 b=U2H60DHOzLHUrg9moAwd6yVFN8JT3qyLdnrPF/ooTY46oeG5SB0pEv0FUmbOa4nnDnMa
 H+X+SAaN/Jl/qLf9rPHbyHI+e9KxnIAenFpmgMLa0mkXg4qdFFgY3eNZopoN10vR/qBi
 kdg9Rd0KaRbr1z/gtNBlkUHzOZQoKkYjiQ+wjQyS3v2DyDkfAON7B5acKfLQtGABNAUu
 Z3TWHnp0xWJIIX8cGfke3syrptqEnJeAbUYsqEcXXNGgS/CU9fpmpaf2trcHZkwwO1Iw
 3oLD8JFlZQlVysOnnYBhzpDRlqRpssYmSHcN7YIQT9+o5RtrRjhgFaFmkwyFA2mIrbP8 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36fhs7g2f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 20:02:47 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11312JCs184970;
        Tue, 2 Feb 2021 20:02:47 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36fhs7g2ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 20:02:46 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 113129m0025015;
        Wed, 3 Feb 2021 01:02:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 36cy381rty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 01:02:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11312g5L45678990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Feb 2021 01:02:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8053A5204E;
        Wed,  3 Feb 2021 01:02:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.101.146])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 651FD52051;
        Wed,  3 Feb 2021 01:02:40 +0000 (GMT)
Message-ID: <2cab86154362ac145d3749d05a06a2d4340264f6.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
Date:   Tue, 02 Feb 2021 20:02:39 -0500
In-Reply-To: <169af4d7-9f1a-69c9-44a8-9d30deab80cb@linux.microsoft.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
         <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
         <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
         <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
         <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
         <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
         <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
         <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
         <fc9a5d48-dc29-0d5d-55dd-bacac346da10@linux.microsoft.com>
         <3f76d250-6aa7-65c1-b903-5bc82f6f8845@linux.microsoft.com>
         <CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com>
         <3f1571d5b9f2fbb6a8ff9a5fad75b54e2b597904.camel@linux.ibm.com>
         <169af4d7-9f1a-69c9-44a8-9d30deab80cb@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-02 at 10:14 -0800, Raphael Gianotti wrote:
> On 2/2/2021 5:07 AM, Mimi Zohar wrote:
> > On Tue, 2021-02-02 at 07:54 +0200, Amir Goldstein wrote:
> >> On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
> >> <raphgi@linux.microsoft.com> wrote:
> >>>
> >>> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
> >>>> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> >>>>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> >>>>>>>>>> But this doesn't address where the offloaded measurement list
> >>>>>>>>>> will be stored, how long the list will be retained, nor who
> >>>>>>>>>> guarantees the integrity of the offloaded list.  In addition,
> >>>>>>>>>> different form factors will have different requirements.
> >>>>>> For how long the list would be retained, or in the case of a log
> >>>>>> segments, it
> >>>>>> might make sense to have that be an admin decision, something that
> >>>>>> can be
> >>>>>> configured to satisfy the needs of a specific system, as mentioned
> >>>>>> below by
> >>>>>> James, does that seem correct?
> >>>>> For the discussion on exporting and truncating the IMA measurement
> >>>>> list, refer to:
> >>>>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
> >>>>>
> >>>>>
> >>>>>> Given the possibility of keeping the logs around for an indefinite
> >>>>>> amount of
> >>>>>> time, would using an expansion of the method present in this RFC be
> >>>>>> more
> >>>>>> appropriate than going down the vfs_tmpfile route? Forgive my lack
> >>>>>> on expertise
> >>>>>> on mm, but would the vfs_tmpfile approach work for keeping several
> >>>>>> log segments
> >>>>>> across multiple kexecs?
> >>>>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> >>>>> segments isn't needed.  The existing mechanism for carrying the
> >>>>> measurement list across kexec would still be used.  Currently, if the
> >>>>> kernel cannot allocate the memory needed for carrying the measurement
> >>>>> across kexec, it simply emits an error message, but continues with the
> >>>>> kexec.
> >>>> In this change I had introduced "exporting" the log to disk when the size
> >>>> of the measurement list was too large. Given part of the motivation
> >>>> behind
> >>>> moving the measurement list is the possibility of it growing too large
> >>>> and taking up too much of the kernel memory, that case would likely lead
> >>>> to kexec not being able to carry over the logs. Do you believe it's
> >>>> better
> >>>> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> >>>> about potential issues with kexec not being able to carry over the logs
> >>>> separately, given the "vfs_tempfile" approach seems to be preferred and
> >>>> also simplifies worries regarding truncating the logs?
> >>> After a chat with Mimi I went ahead and did some investigative
> >>> work in the vfs_tmpfile approach suggested, and I wanted to
> >>> restart this thread with some thoughts/questions that came up
> >>> from that.
> >>> For the work I did I simply created a tmp file during ima's
> >>> initialization and then tried to use vm_mmap to map it to memory,
> >>> with the goal of using that memory mapping to generate return
> >>> pointers to the code that writes the measurement entries to memory.
> >> I don't understand why you would want to do that. I might have misunderstood
> >> the requirements, but this was not how I meant for tmpfile to be used.
> >>
> >> Mimi explained to me that currently the IMA measurement list is entirely in
> >> memory and that you are looking for a way to dump it into a file in order to
> >> free up memory.
> >>
> >> What I suggested is this:
> >>
> >> - User opens an O_TMPFILE and passes fd to IMA to start export
> >> - IMA starts writing (exporting) records to that file using *kernel* write API
> >> - Every record written to the file is removed from the in-memory list
> >> - While list is being exported, IMA keeps in-memory count of exported entries
> >> - In ima_measurements_start, if export file exists, start iterator
> >> starts reading
> >>    records from the file
> >> - In ima_measurements_next(), when next iterator reaches the export count,
> >>    it switches over to iterate in-memory list
> >>
> >> This process can:
> >> 1. Continue forever without maintaining any in-memory list
> >> 2. Work in the background to periodically flush list to file
> >> 3. Controlled by explicit user commands
> >> 4. All of the above
> >>
> >> Is that understood? Did I understand the requirements correctly?
> 
> Thanks for the clarification Amir, I never actually saw your initial mails,
> I apologize for the confusion, the use of mmap was something the original
> author of the export ima logs to disk mentioned had been suggested, which
> is why I went down that route.
> Given the actual suggestion you originally had given, I believe the coding
> of it is somewhat to the code I sent in the RFC in terms of approach (if we
> were to have it do periodic flushes, for example). With the addition of
> reads to the log starting with the file as the oldest logs will be there.
> I believe the only difference there is whether the list is kept in a tmp
> file or not, so with the tmp file approach it would be just to keep the
> list out of memory (either partially or permanently), where with a permanent
> file, the list would still be available after a cold boot for instance.

With Amir's suggestion, userspace still accesses the entire measurement
list via the existing securityfs interface.  Only the kernel should be
able to append or access the file.

Mimi

