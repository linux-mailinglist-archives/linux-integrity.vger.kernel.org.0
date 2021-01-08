Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDBD2EF29B
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Jan 2021 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAHMjY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Jan 2021 07:39:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbhAHMjY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jan 2021 07:39:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 108CWH1j129369;
        Fri, 8 Jan 2021 07:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9WUjq2a9S7jh0LFexPEehScoiNInFQI0hx81mT/OLgk=;
 b=I9D40xaGHF4ZnXJS+oqwlT7zPcNv8VDxDT9RiQ29f0PtTiSVc+uzv5rAnO+mhlba3iSw
 vYKcUOt0SRygv5ahFdpne1fs7A1awkT748b2IuIwGSCiWB1aCKef32rLHwvravVUvOFN
 V68f7R1CYq2NIE3EMDQTrWQvBEKifagvWUawoULRhTsvOYH0X0a6d3ueI81aHVP9IJwU
 thwD81aKu+m3PXg6DJu41RX/qWtKZamGhf7A5oeMPwDeT24kIcQZv5j+EQ4OfiiSZPbU
 BPXMUm5Z/B1uQRp+BUnO9k+aLYMfoiOjg4vyZBgorjUfzae7yTC8szDBi4jQ0YubAU4j xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xqcc0aq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 07:38:42 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 108CWRCx130095;
        Fri, 8 Jan 2021 07:38:41 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35xqcc0apa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 07:38:41 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 108CWmhh003996;
        Fri, 8 Jan 2021 12:38:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8e36y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 12:38:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 108CcbZn42270978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jan 2021 12:38:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E840A4051;
        Fri,  8 Jan 2021 12:38:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7388A405D;
        Fri,  8 Jan 2021 12:38:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.88.40])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jan 2021 12:38:34 +0000 (GMT)
Message-ID: <8c78437d0e9a4968996b834030661b6f567f87eb.camel@linux.ibm.com>
Subject: Re: [RFC] Persist ima logs to disk
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com, Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 08 Jan 2021 07:38:33 -0500
In-Reply-To: <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
References: <20210105195742.2629-1-raphgi@linux.microsoft.com>
         <87127d502bcb9707dd4e7a43475ab6bed2fdd421.camel@linux.ibm.com>
         <715a265180a092754ab9ea8522c39427645b25ad.camel@HansenPartnership.com>
         <6e28c7a9742131cf508e77448bfee0a03b2c2e5e.camel@linux.ibm.com>
         <3c50bc449aae2f09bd7d43c401cc9b292f9ec2ae.camel@HansenPartnership.com>
         <570d54ca679b7a4f786fa65eb78601a2af91c397.camel@linux.ibm.com>
         <13447f30db609d4bd77d5a826c5102dd5a931a19.camel@HansenPartnership.com>
         <734adc26-0050-ce8f-4c8c-c8a907b569a6@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_07:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 14:57 -0800, Raphael Gianotti wrote:
> >>>> But this doesn't address where the offloaded measurement list
> >>>> will be stored, how long the list will be retained, nor who
> >>>> guarantees the integrity of the offloaded list.  In addition,
> >>>> different form factors will have different requirements.
> 
> For how long the list would be retained, or in the case of a log segments, it
> might make sense to have that be an admin decision, something that can be
> configured to satisfy the needs of a specific system, as mentioned below by
> James, does that seem correct?

For the discussion on exporting and truncating the IMA measurement
list, refer to: 
https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/

> 
> Given the possibility of keeping the logs around for an indefinite amount of
> time, would using an expansion of the method present in this RFC be more
> appropriate than going down the vfs_tmpfile route? Forgive my lack on expertise
> on mm, but would the vfs_tmpfile approach work for keeping several log segments
> across multiple kexecs?

With the "vfs_tmpfile" mechanism, breaking up and saving the log in
segments isn't needed.  The existing mechanism for carrying the
measurement list across kexec would still be used.  Currently, if the
kernel cannot allocate the memory needed for carrying the measurement
across kexec, it simply emits an error message, but continues with the
kexec.

Mimi

