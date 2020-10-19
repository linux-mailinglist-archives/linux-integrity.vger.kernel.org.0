Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCB293141
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbgJSWaW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 18:30:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730439AbgJSWaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 18:30:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JM2Vdk045216;
        Mon, 19 Oct 2020 18:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=68BfF6TjbBTG63EcWUjtb24MLdst39eMhaG0zxrgLEY=;
 b=AlWtTOmTyZbeOIKg1jr47p04xfSpZJOaVSv54zRL9VG0Jwj6KrKnt9C6N/1gRdfwg+e4
 XFaS1Lz58MkQtkdIIaoEmW476AwuPpdTW59ABv5ZK5/ENS+l33fBMkJDmx6ySD/zMuKI
 HyaeHSnE1WvZJehMAO4dcr2Wvy+EN3ycrYr5bQB8StxPh3GLMlMdqnlYu3yYJYQAJrt1
 5G+bqmDovqVRlI8jJjDCgwa/6Uq44xhV6GWVq/ufuaEBiq9ntFp9DJg+PFLQjyqFUg6N
 tWJ3Q2IeVH+rTWh4G+M48WcfjZfbXnxseVh1BYi4+9Qbzszva9E+F7QSBn8ypeyfa0oN DQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 349k7pgmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 18:30:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09JMMUvk018057;
        Mon, 19 Oct 2020 22:30:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 347r88ajrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 22:30:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09JMU7ZE32309694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 22:30:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E5FC4C04A;
        Mon, 19 Oct 2020 22:30:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BE964C059;
        Mon, 19 Oct 2020 22:30:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.104.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Oct 2020 22:30:06 +0000 (GMT)
Message-ID: <b0b0c3f0199333c7ef909c7ffcb22036e83e92bd.camel@linux.ibm.com>
Subject: Re: [PATCH] file2bin: Pass the right values to size and count
 parameters for fread()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 19 Oct 2020 18:30:05 -0400
In-Reply-To: <d4c7c8f3-e6b4-a962-c402-88982f86b79f@linux.microsoft.com>
References: <20201019200526.12678-1-nramas@linux.microsoft.com>
         <9dd83103f724484a8f1febb37b54616d136930fe.camel@linux.ibm.com>
         <d4c7c8f3-e6b4-a962-c402-88982f86b79f@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_11:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-19 at 15:22 -0700, Lakshmi Ramasubramanian wrote:
> On 10/19/20 3:12 PM, Mimi Zohar wrote:
> > Hi Lakshmi,
> > 
> > On Mon, 2020-10-19 at 13:05 -0700, Lakshmi Ramasubramanian wrote:
> >> The 2nd parameter to fread() namely "size" specifies the size, in
> >> bytes of each element to be read, and the 3rd parameter namely "count"
> >> specifies the number of elements, each one with a size of "size" bytes.
> >>
> >>   size_t fread ( void * ptr, size_t size, size_t count, FILE * stream );
> >>
> >> But in the function file2bin() the values passed to "size" and "count"
> >> are reversed causing the function to return an error eventhough the file
> >> was sucdessfully read.
> >>
> >> Pass the right values to "size" and "count" parameters for fread() in
> >> the function file2bin().
> >>
> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> ---
> >>   src/evmctl.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/src/evmctl.c b/src/evmctl.c
> >> index 7ad1150..d49988e 100644
> >> --- a/src/evmctl.c
> >> +++ b/src/evmctl.c
> >> @@ -221,7 +221,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> >>   		fclose(fp);
> >>   		return NULL;
> >>   	}
> >> -	if (fread(data, len, 1, fp) != len) {
> >> +
> >> +	if (fread(data, 1, len, fp) != len) {
> >>   		log_err("Failed to fread %zu bytes: %s\n", len, name);
> >>   		fclose(fp);
> >>   		free(data);
> > 
> > Wasn't this problem addressed by Vitaly's patch.  Please look at commit
> > c89e8508864b ("ima-evm-utils: Fix reading of sigfile").
> > 
> 
> You are right Mimi. I missed the patch posted by Vitaly. Sorry for the 
> duplicate one.
> 
> Looks like Vitaly's change hasn't been merged to "master" branch yet in 
> https://github.com/pevik/ima-evm-utils

Only after the release would it be in master.   Until then it would be
in next, which it isn't either.   Can I add your Reviewed-by tag on
this patched? 

thanks,

Mimi


