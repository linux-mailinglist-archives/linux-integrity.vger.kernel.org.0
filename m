Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D744202E
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhKASmM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 14:42:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232027AbhKASmJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 14:42:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GcDTt006264;
        Mon, 1 Nov 2021 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Nzr7lR3aQ3VBWsphZ1B0qGLbhoXGUME2mUDbdc/i00o=;
 b=pdY7NFx5B0KWE423L8WQ/0cl+JeGn22QLbkHgvEkw/MIcnXHMALPLlDa0AAT141uYa8G
 bZz9nf+f6bntn2o70s8BB0PREsoVfixI/Esw73//Ki2RH8vCeV0IyQ3xDjkZr5gJOw4B
 i6fe5ZtaaXPPMydwHyBUXZPtLveKNxoEbpqUObFVbC+dj14GySWPbMcbBCSGlFu51bWx
 MH4rArPQF697kkInBVnXJ/CwAPom16m97PZfJ1F5CAjXMo9qVWtgnQlc7dk5lyWLsyE/
 e5ja3jUcEtQ64kLZTj9BFv93qsyowG+oEUlYAt2z7Z2WgE+DIjnbjZDXC0TGn4zzOd7h 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c2dfgjcuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 18:39:32 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A1IR5eM009614;
        Mon, 1 Nov 2021 18:39:31 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c2dfgjcu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 18:39:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A1IdA31003101;
        Mon, 1 Nov 2021 18:39:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3c0wpauum5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 18:39:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A1IX5Hl42336726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Nov 2021 18:33:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D0542041;
        Mon,  1 Nov 2021 18:39:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CFE542042;
        Mon,  1 Nov 2021 18:39:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.124.155])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Nov 2021 18:39:26 +0000 (GMT)
Message-ID: <4d0f219c941bf096658d78a95ca566a76b15b082.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 1/2] switch to using crun for podman
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Date:   Mon, 01 Nov 2021 14:39:26 -0400
In-Reply-To: <YXfwoOEZZKKII6s9@pevik>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
         <YXfwoOEZZKKII6s9@pevik>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cAwzuYiDbCmbo0rUx4GqK7PTcqmDB6Ql
X-Proofpoint-ORIG-GUID: FVBJPDFu2kbdZOv_uFXuOw7eR93AqZLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010099
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2021-10-26 at 14:12 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > Fix for:
> 
> > "container_linux.go:367: starting container process caused: error
> > adding seccomp filter rule for syscall bdflush: permission denied":
> > OCI permission denied"
> 
> I was surprised crun is updated but runc not, but LGTM.
> It'd be nice if somebody test it with public travis (I no longer have access).

Stefan tested on the public travis, which resulted in updating Alpine,
Fedora, and Alt to use podman and crun.  Other than the alt:sisyphus
image prompt, the tests all pass.  I assume this is intermittent.
    
     Please select an image:
      ▸ docker.io/library/alt:sisyphus
        quay.io/alt:sisyphus

> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

thanks!

Mimi

> 
> IMHO from a long term perspective it'd be nice to create GitHub Actions profile
> (but that's not related to this patchset).



