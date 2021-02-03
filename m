Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC130E2BF
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 19:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBCSqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 13:46:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhBCSqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 13:46:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 113IGXLC056625;
        Wed, 3 Feb 2021 13:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eUBMH2IrKYsM76fuDcn1FKF1AiEpXskHJ2q2pBgiMLw=;
 b=rTROD8s8bbNM9JRdJL88BVTFdAJvAF/E3lw+OzzlVcrwG8lRV7116MlxrIcgk26YF0Ip
 2SPUCSHFH5VqqghjcRIVbl7SLKQVll7TK4PyUxl7/m4v7Sz8LVu31pAAFf466YMK1qP9
 BZ7rCA969MCYnNXWVf7pABAYT+VIPEmAIJOx6eweAutOowEDmAMs7v8vMAnF6/VOuZuy
 ydFOgPvZPzcPEZQBHZaccdYOj/JoGj5D3dY/yHAIk34obz9yA5LsXONc7+R6bHAv10CS
 Qo1/YUUbjcYBOwJh61NEKYD4Bd6YPoW7IkSdoVr7FVl+DDCxFk5oq3TiFmN5ygpb+gzq JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36g0yc8pnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 13:46:00 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 113Ib0en000869;
        Wed, 3 Feb 2021 13:45:59 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36g0yc8pmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 13:45:59 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 113Ic7jp005672;
        Wed, 3 Feb 2021 18:45:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36fwcw06k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 18:45:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 113Ijtv123003564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Feb 2021 18:45:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E19F3A4055;
        Wed,  3 Feb 2021 18:45:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C0F7A404D;
        Wed,  3 Feb 2021 18:45:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.101.146])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Feb 2021 18:45:52 +0000 (GMT)
Message-ID: <854f65b13f3f742153c862d68823d4d69ddc1bcd.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
Date:   Wed, 03 Feb 2021 13:45:52 -0500
In-Reply-To: <CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com>
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
         <2cab86154362ac145d3749d05a06a2d4340264f6.camel@linux.ibm.com>
         <CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_07:2021-02-03,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102030102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-02-03 at 09:24 +0200, Amir Goldstein wrote:
> On Wed, Feb 3, 2021 at 3:02 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2021-02-02 at 10:14 -0800, Raphael Gianotti wrote:
> > > On 2/2/2021 5:07 AM, Mimi Zohar wrote:
> > > > On Tue, 2021-02-02 at 07:54 +0200, Amir Goldstein wrote:
> > > >> On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
> > > >> <raphgi@linux.microsoft.com> wrote:
> > > >>>
> > > >>> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
> > > >>>> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> > > >>>>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> > > >>>>>>>>>> But this doesn't address where the offloaded measurement list
> > > >>>>>>>>>> will be stored, how long the list will be retained, nor who
> > > >>>>>>>>>> guarantees the integrity of the offloaded list.  In addition,
> > > >>>>>>>>>> different form factors will have different requirements.
> > > >>>>>> For how long the list would be retained, or in the case of a log
> > > >>>>>> segments, it
> > > >>>>>> might make sense to have that be an admin decision, something that
> > > >>>>>> can be
> > > >>>>>> configured to satisfy the needs of a specific system, as mentioned
> > > >>>>>> below by
> > > >>>>>> James, does that seem correct?
> > > >>>>> For the discussion on exporting and truncating the IMA measurement
> > > >>>>> list, refer to:
> > > >>>>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
> > > >>>>>
> > > >>>>>
> > > >>>>>> Given the possibility of keeping the logs around for an indefinite
> > > >>>>>> amount of
> > > >>>>>> time, would using an expansion of the method present in this RFC be
> > > >>>>>> more
> > > >>>>>> appropriate than going down the vfs_tmpfile route? Forgive my lack
> > > >>>>>> on expertise
> > > >>>>>> on mm, but would the vfs_tmpfile approach work for keeping several
> > > >>>>>> log segments
> > > >>>>>> across multiple kexecs?
> > > >>>>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> > > >>>>> segments isn't needed.  The existing mechanism for carrying the
> > > >>>>> measurement list across kexec would still be used.  Currently, if the
> > > >>>>> kernel cannot allocate the memory needed for carrying the measurement
> > > >>>>> across kexec, it simply emits an error message, but continues with the
> > > >>>>> kexec.
> > > >>>> In this change I had introduced "exporting" the log to disk when the size
> > > >>>> of the measurement list was too large. Given part of the motivation
> > > >>>> behind
> > > >>>> moving the measurement list is the possibility of it growing too large
> > > >>>> and taking up too much of the kernel memory, that case would likely lead
> > > >>>> to kexec not being able to carry over the logs. Do you believe it's
> > > >>>> better
> > > >>>> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> > > >>>> about potential issues with kexec not being able to carry over the logs
> > > >>>> separately, given the "vfs_tempfile" approach seems to be preferred and
> > > >>>> also simplifies worries regarding truncating the logs?
> > > >>> After a chat with Mimi I went ahead and did some investigative
> > > >>> work in the vfs_tmpfile approach suggested, and I wanted to
> > > >>> restart this thread with some thoughts/questions that came up
> > > >>> from that.
> > > >>> For the work I did I simply created a tmp file during ima's
> > > >>> initialization and then tried to use vm_mmap to map it to memory,
> > > >>> with the goal of using that memory mapping to generate return
> > > >>> pointers to the code that writes the measurement entries to memory.
> > > >> I don't understand why you would want to do that. I might have misunderstood
> > > >> the requirements, but this was not how I meant for tmpfile to be used.
> > > >>
> > > >> Mimi explained to me that currently the IMA measurement list is entirely in
> > > >> memory and that you are looking for a way to dump it into a file in order to
> > > >> free up memory.
> > > >>
> > > >> What I suggested is this:
> > > >>
> > > >> - User opens an O_TMPFILE and passes fd to IMA to start export
> > > >> - IMA starts writing (exporting) records to that file using *kernel* write API
> > > >> - Every record written to the file is removed from the in-memory list
> > > >> - While list is being exported, IMA keeps in-memory count of exported entries
> > > >> - In ima_measurements_start, if export file exists, start iterator
> > > >> starts reading
> > > >>    records from the file
> > > >> - In ima_measurements_next(), when next iterator reaches the export count,
> > > >>    it switches over to iterate in-memory list
> > > >>
> > > >> This process can:
> > > >> 1. Continue forever without maintaining any in-memory list
> > > >> 2. Work in the background to periodically flush list to file
> > > >> 3. Controlled by explicit user commands
> > > >> 4. All of the above
> > > >>
> > > >> Is that understood? Did I understand the requirements correctly?
> > >
> > > Thanks for the clarification Amir, I never actually saw your initial mails,
> > > I apologize for the confusion, the use of mmap was something the original
> > > author of the export ima logs to disk mentioned had been suggested, which
> > > is why I went down that route.
> > > Given the actual suggestion you originally had given, I believe the coding
> > > of it is somewhat to the code I sent in the RFC in terms of approach (if we
> > > were to have it do periodic flushes, for example). With the addition of
> > > reads to the log starting with the file as the oldest logs will be there.
> > > I believe the only difference there is whether the list is kept in a tmp
> > > file or not, so with the tmp file approach it would be just to keep the
> > > list out of memory (either partially or permanently), where with a permanent
> > > file, the list would still be available after a cold boot for instance.
> >
> > With Amir's suggestion, userspace still accesses the entire measurement
> > list via the existing securityfs interface.  Only the kernel should be
> > able to append or access the file.
> >
> 
> This user API is not an important part of the suggestion:
> 
> - User opens an O_TMPFILE and passes fd to IMA to start export
> 
> It is just how I understood the API should be.
> Kernel could open the O_TMPFILE or named file for that matter just as well.
> If the kernel opens an O_TMPFILE, userspace has no standard way to access
> that file. There are, as always, ways for privileged users to learn about that
> tmpfile and open it with open_by_handle_at().
> 
> IMA is an LSM, so the best way to block unauthorized access to that file
> would be via LSM hooks. IMA keeps a reference to that file, so it can
> identify access to that file from userspace.

Having the kernel open a O_TMPFILE and use/define additional LSM hooks,
as needed, to limit access to the file sounds good.

In terms of the rest of the userspace interface, I would probably
define a new IMA securityfs file to control the frequency that the
measurements are written to the file (e.g. 0 == never, 1 == enabled
with default frequency, anything else frequency).

thanks,

Mimi

