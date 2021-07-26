Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FB23D63EE
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhGZPxO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 11:53:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39158 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239501AbhGZPxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 11:53:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QGGU4U141734;
        Mon, 26 Jul 2021 12:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GXev3BrJvfr2qmOMBE/8/eqbgtynsnNNzf5FrP5ufdA=;
 b=sW9TvzgskbgYyUfznLW2Ea4dTZy9zhxMYS6IXb1kUhVf+LGTm/hcra0EUqrwJO9exrLj
 tdbv27ODiARVCYf5kr3Z8S4/q73DlGKBgxmcfDvABwI3ueP/HdZ+faJTdwJeqSJrDMIh
 6i7iS85OijAcg20F/uSrXPuoV7fLCYhP5T2y9YfC0BuWEXXQpVuUkGN4Xj1w9LVYTZWJ
 ZV4Mfiv2cQ83HXtX5AnxyOkN9zLwNo6v4Baad2Mk2DOH4GYr4vY5TIBf8dVgVhMNnA+5
 U16kSBB02YnFkqnxieo4ME5/FGpFF1p9/tFTjdY+GUTAj+X25Z7VBTqUZUwEKz2EPmIT oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a20e1rkyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 12:33:29 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16QGIUMo147316;
        Mon, 26 Jul 2021 12:33:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a20e1rky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 12:33:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QGXFkD003110;
        Mon, 26 Jul 2021 16:33:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3a0ag8rsgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 16:33:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16QGUkD925559434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 16:30:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2596211C04C;
        Mon, 26 Jul 2021 16:33:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B006D11C04A;
        Mon, 26 Jul 2021 16:33:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.94])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Jul 2021 16:33:22 +0000 (GMT)
Message-ID: <8cea95cdc1349ae60c690c45ddabcd676c5774d2.camel@linux.ibm.com>
Subject: Re: [PATCH 7/7] dm: add documentation for IMA measurement support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
Date:   Mon, 26 Jul 2021 12:33:21 -0400
In-Reply-To: <6b81b92f-7d7b-d198-5056-bab1bcbac522@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
         <20210713004904.8808-8-tusharsu@linux.microsoft.com>
         <205b5336d60aee6b3f33ad67b2d0250e104d6779.camel@linux.ibm.com>
         <6b81b92f-7d7b-d198-5056-bab1bcbac522@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _i1zpNSZi7F2wvEVb4PHQGSMRvpBKdsB
X-Proofpoint-GUID: w264wuaY1Rodi7jYfEViBQrLjpYrRtB3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Sat, 2021-07-24 at 00:25 -0700, Tushar Sugandhi wrote:
> Hi Mimi,
> 
> 
> > Missing from the document is a way of validating the template data.
> > For example, in the original case of file measurements, the template
> > data contains the file hash, which can be recalculated or verified
> > against an allow list.
> > 
> > Other than re-calculating the template data digest based on the
> > template data, and verifying it against the template data digest in the
> > measurement list, would an attestation server be able to verify the
> > template data itself?
> >
> Yes.
> In the context of device-mapper, EVENT_DATA for 'table_load' would
> contain the key-value pairs for various targets in the table
> (crypt, verity, integrity etc.) which the attestation servers
> should be able to verify against the allowed/expected
> key-value pairs specified in the attestation policy.
> 
> To avoid bloating the IMA log with same data from table_load again,
> we only measure hash of the loaded table in the EVENT_DATA -
> when there is a state change for DM device.
> e.g. when EVENT_NAME is 'device_resume', 'table_clear',
> 'device_remove' etc.
> 
> Since the table clear-text is already present in the EVENT_DATA
> buffer for 'table_load', and is available to attestation servers,
> verifying the corresponding hash values in the
> EVENT_DATA in the subsequent DM events should be possible for
> the attestation servers.
> 
> Please let us know if you need further info.

For regular files with signatures, the file signature is verified
against the file hash, both contained within the template data.  For
the SELinux "critical-data", 
commit 2554a48f4437 ("selinux: measure state and policy capabilities")
contains that information.  Missing from this patch set is information
on how the attestation server could verify the DM critical data.

Does the DM record contain everything needed for the attestion server
to verify the template record?  Are things like the hash algorithm hard
coded?

thanks,

Mimi



