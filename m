Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68C03156D6
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhBITca (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 14:32:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233580AbhBITUE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 14:20:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119HpWYU082878;
        Tue, 9 Feb 2021 13:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KmoiSyAI/M5vm0a2TSBax/lVOjZdg/IZmmy8E6lFSnY=;
 b=U+aFZXvB30g7mui0bPbtfHNVSYcXbOSRM7qZvU1OzyZK5kJ2dR+ugSCYL83yyykc+Q+5
 AEq3n8if3uQQd3fnqknyHLWyurRJPGAgsxySPvC5gKO8fM6WVZ2L/Bal+NvGGSgujArJ
 PV2KkTQ1YzMZgSEJsWJyUfyABZCSOObt7gZpoMgDdRvPnhmMpmoPMRP3KU7+PrG4M/XY
 WMTRHnEVu1jDvtibcDvotxjjySaHHtJzsagCgQ6m70UFaWthUbhItJv2gRq5p0Jp7OZq
 eywZdQPrcPpZhuz5izfZfzXR/Vq5Yy9JmrWh3dp3bgUAW4AhfkHYpMiMevkIHoeao33C kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ky5r0f2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 13:08:13 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 119Hpri1084229;
        Tue, 9 Feb 2021 13:08:13 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ky5r0f1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 13:08:13 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119I2wqe029802;
        Tue, 9 Feb 2021 18:08:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 36hjr8bp1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 18:08:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119I7xAS33423800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 18:07:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38D57AE045;
        Tue,  9 Feb 2021 18:08:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0BC8AE051;
        Tue,  9 Feb 2021 18:08:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.210])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 18:08:07 +0000 (GMT)
Message-ID: <4c210f35a2892d85438c17fb892bd804f488a4e7.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        janne.karhunen@gmail.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com
Date:   Tue, 09 Feb 2021 13:08:06 -0500
In-Reply-To: <41e4222e-8daa-ff80-df6d-e546772faf59@linux.microsoft.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
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
         <854f65b13f3f742153c862d68823d4d69ddc1bcd.camel@linux.ibm.com>
         <41e4222e-8daa-ff80-df6d-e546772faf59@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-09 at 09:20 -0800, Raphael Gianotti wrote:
> On 2/3/2021 10:45 AM, Mimi Zohar wrote:
> > On Wed, 2021-02-03 at 09:24 +0200, Amir Goldstein wrote:
> >> On Wed, Feb 3, 2021 at 3:02 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> On Tue, 2021-02-02 at 10:14 -0800, Raphael Gianotti wrote:
> >>>> On 2/2/2021 5:07 AM, Mimi Zohar wrote:
> >>>>> On Tue, 2021-02-02 at 07:54 +0200, Amir Goldstein wrote:
> >>>>>> On Tue, Feb 2, 2021 at 12:53 AM Raphael Gianotti
> >>>>>> <raphgi@linux.microsoft.com> wrote:
> >>>>>>> On 1/8/2021 9:58 AM, Raphael Gianotti wrote:
> >>>>>>>> On 1/8/2021 4:38 AM, Mimi Zohar wrote:
> >>>>>>>>> On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> >>>>>>>>>>>>>> But this doesn't address where the offloaded measurement list
> >>>>>>>>>>>>>> will be stored, how long the list will be retained, nor who
> >>>>>>>>>>>>>> guarantees the integrity of the offloaded list.  In addition,
> >>>>>>>>>>>>>> different form factors will have different requirements.
> >>>>>>>>>> For how long the list would be retained, or in the case of a log
> >>>>>>>>>> segments, it
> >>>>>>>>>> might make sense to have that be an admin decision, something that
> >>>>>>>>>> can be
> >>>>>>>>>> configured to satisfy the needs of a specific system, as mentioned
> >>>>>>>>>> below by
> >>>>>>>>>> James, does that seem correct?
> >>>>>>>>> For the discussion on exporting and truncating the IMA measurement
> >>>>>>>>> list, refer to:
> >>>>>>>>> https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> Given the possibility of keeping the logs around for an indefinite
> >>>>>>>>>> amount of
> >>>>>>>>>> time, would using an expansion of the method present in this RFC be
> >>>>>>>>>> more
> >>>>>>>>>> appropriate than going down the vfs_tmpfile route? Forgive my lack
> >>>>>>>>>> on expertise
> >>>>>>>>>> on mm, but would the vfs_tmpfile approach work for keeping several
> >>>>>>>>>> log segments
> >>>>>>>>>> across multiple kexecs?
> >>>>>>>>> With the "vfs_tmpfile" mechanism, breaking up and saving the log in
> >>>>>>>>> segments isn't needed.  The existing mechanism for carrying the
> >>>>>>>>> measurement list across kexec would still be used.  Currently, if the
> >>>>>>>>> kernel cannot allocate the memory needed for carrying the measurement
> >>>>>>>>> across kexec, it simply emits an error message, but continues with the
> >>>>>>>>> kexec.
> >>>>>>>> In this change I had introduced "exporting" the log to disk when the size
> >>>>>>>> of the measurement list was too large. Given part of the motivation
> >>>>>>>> behind
> >>>>>>>> moving the measurement list is the possibility of it growing too large
> >>>>>>>> and taking up too much of the kernel memory, that case would likely lead
> >>>>>>>> to kexec not being able to carry over the logs. Do you believe it's
> >>>>>>>> better
> >>>>>>>> to use the "vfs_tmpfile" mechanism for moving the logs to disk and worry
> >>>>>>>> about potential issues with kexec not being able to carry over the logs
> >>>>>>>> separately, given the "vfs_tempfile" approach seems to be preferred and
> >>>>>>>> also simplifies worries regarding truncating the logs?
> >>>>>>> After a chat with Mimi I went ahead and did some investigative
> >>>>>>> work in the vfs_tmpfile approach suggested, and I wanted to
> >>>>>>> restart this thread with some thoughts/questions that came up
> >>>>>>> from that.
> >>>>>>> For the work I did I simply created a tmp file during ima's
> >>>>>>> initialization and then tried to use vm_mmap to map it to memory,
> >>>>>>> with the goal of using that memory mapping to generate return
> >>>>>>> pointers to the code that writes the measurement entries to memory.
> >>>>>> I don't understand why you would want to do that. I might have misunderstood
> >>>>>> the requirements, but this was not how I meant for tmpfile to be used.
> >>>>>>
> >>>>>> Mimi explained to me that currently the IMA measurement list is entirely in
> >>>>>> memory and that you are looking for a way to dump it into a file in order to
> >>>>>> free up memory.
> >>>>>>
> >>>>>> What I suggested is this:
> >>>>>>
> >>>>>> - User opens an O_TMPFILE and passes fd to IMA to start export
> >>>>>> - IMA starts writing (exporting) records to that file using *kernel* write API
> >>>>>> - Every record written to the file is removed from the in-memory list
> >>>>>> - While list is being exported, IMA keeps in-memory count of exported entries
> >>>>>> - In ima_measurements_start, if export file exists, start iterator
> >>>>>> starts reading
> >>>>>>     records from the file
> >>>>>> - In ima_measurements_next(), when next iterator reaches the export count,
> >>>>>>     it switches over to iterate in-memory list
> >>>>>>
> >>>>>> This process can:
> >>>>>> 1. Continue forever without maintaining any in-memory list
> >>>>>> 2. Work in the background to periodically flush list to file
> >>>>>> 3. Controlled by explicit user commands
> >>>>>> 4. All of the above
> >>>>>>
> >>>>>> Is that understood? Did I understand the requirements correctly?
> >>>> Thanks for the clarification Amir, I never actually saw your initial mails,
> >>>> I apologize for the confusion, the use of mmap was something the original
> >>>> author of the export ima logs to disk mentioned had been suggested, which
> >>>> is why I went down that route.
> >>>> Given the actual suggestion you originally had given, I believe the coding
> >>>> of it is somewhat to the code I sent in the RFC in terms of approach (if we
> >>>> were to have it do periodic flushes, for example). With the addition of
> >>>> reads to the log starting with the file as the oldest logs will be there.
> >>>> I believe the only difference there is whether the list is kept in a tmp
> >>>> file or not, so with the tmp file approach it would be just to keep the
> >>>> list out of memory (either partially or permanently), where with a permanent
> >>>> file, the list would still be available after a cold boot for instance.
> >>> With Amir's suggestion, userspace still accesses the entire measurement
> >>> list via the existing securityfs interface.  Only the kernel should be
> >>> able to append or access the file.
> >>>
> >> This user API is not an important part of the suggestion:
> >>
> >> - User opens an O_TMPFILE and passes fd to IMA to start export
> >>
> >> It is just how I understood the API should be.
> >> Kernel could open the O_TMPFILE or named file for that matter just as well.
> >> If the kernel opens an O_TMPFILE, userspace has no standard way to access
> >> that file. There are, as always, ways for privileged users to learn about that
> >> tmpfile and open it with open_by_handle_at().
> >>
> >> IMA is an LSM, so the best way to block unauthorized access to that file
> >> would be via LSM hooks. IMA keeps a reference to that file, so it can
> >> identify access to that file from userspace.
> > Having the kernel open a O_TMPFILE and use/define additional LSM hooks,
> > as needed, to limit access to the file sounds good.
> >
> > In terms of the rest of the userspace interface, I would probably
> > define a new IMA securityfs file to control the frequency that the
> > measurements are written to the file (e.g. 0 == never, 1 == enabled
> > with default frequency, anything else frequency).
> >
> > thanks,
> >
> > Mimi
> 
> Regarding the comparison between the original approach in the RFC,
> using permanent files, and the TMP file approach (with me having the
> correct suggestion in mind now), I believe there are still some
> benefits from having a file be permanent:
> 	- It provides a way to always keep the logs across the kexec
> 	  boundary, regardless of how much they've grown in size,
> 	  as the file will persist through it, where as with a tmp
> 	  file, the ability to persist the logs through kexec would
> 	  still be subject to the same memory restrictions it currently
> 	  is.
> 	- It provides a way for an attestation service to have a
> 	  history of measurements performed during previous cold boot
> 	  cycles.
> 
> The above, however, does introduce the requirements of persisting
> PCR information that would allow verifying historical logs, and
> that information would have to be verifiable in some way (for instance,
> by having the TPM add a signature alongside the logs).
> 
> I think both solutions have their merits, and the TMP file approach
> seems much simpler overall. What I have in mind is perhaps having this
> be configurable, where a file can be defined to hold the logs, but
> the persisting of logs to disk can still be turned on without that
> file being configures, leading to a TMP file being used. That would
> leave it up to the admin to decide whether a permanent file is needed.
> 
> The above is in addition to any other configurations that may be
> applicable, such as one for the frequency as suggested by Mimi.

With the existing mechanism of exporting the IMA measurement list,
userspace can do whatever it likes with it and save it wherever it
likes (e.g. define a cron job to export the measurement list, the
number of measurements, and the TPM PCRs, even storing in a block
chain).  I don't see the benefit in defining a new kernel mechanism for
exporting the IMA measurement list.

Mimi

