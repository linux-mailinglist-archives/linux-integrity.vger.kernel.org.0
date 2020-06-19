Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90C3201E00
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Jun 2020 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgFSWZc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 18:25:32 -0400
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:40108 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729340AbgFSWZc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 18:25:32 -0400
X-Greylist: delayed 5998 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 18:25:31 EDT
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
        by m0048274.ppops.net-00176a03. (8.16.0.42/8.16.0.42) with SMTP id 05JKa7wG021522
        for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2020 16:45:32 -0400
From:   "Wiseman, Monty (GE Research, US)" <monty.wiseman@ge.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Thread-Topic: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
Thread-Index: AQHVrm5195ieaeCZS021izerlQeab6jhjcnQ
Date:   Fri, 19 Jun 2020 20:45:24 +0000
Message-ID: <26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781746.14069.11.camel@HansenPartnership.com>
 <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
In-Reply-To: <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jTWpFeU5UYzJNalU1WEdGd2NHUmhkR0ZjY205aGJXbHVaMXd3T1dRNE5E?=
 =?utf-8?B?bGlOaTB6TW1RekxUUmhOREF0T0RWbFpTMDJZamcwWW1FeU9XVXpOV0pjYlhO?=
 =?utf-8?B?bmMxeHRjMmN0WXpVNVpHSmxZVFl0WWpJMlpDMHhNV1ZoTFRreFlqa3RZVGcy?=
 =?utf-8?B?WkdGaE1tRmxZMlkyWEdGdFpTMTBaWE4wWEdNMU9XUmlaV0U0TFdJeU5tUXRN?=
 =?utf-8?B?VEZsWVMwNU1XSTVMV0U0Tm1SaFlUSmhaV05tTm1KdlpIa3VkSGgwSWlCemVq?=
 =?utf-8?B?MGlNemMyTkNJZ2REMGlNVE15TXpjd056TXhNakkyTkRnMU9USXpJaUJvUFNJ?=
 =?utf-8?B?MmJtVlphV1ZCYldsRWMwNTBia2hRTkhSWlQwRXhSMEV4WW5NOUlpQnBaRDBp?=
 =?utf-8?B?SWlCaWJEMGlNQ0lnWW04OUlqRWlJR05wUFNKalFVRkJRVVZTU0ZVeFVsTlNW?=
 =?utf-8?B?VVpPUTJkVlFVRkZiME5CUVVOcU1VZHRUbVZyWWxkQlYwVm5jelZ0ZFZoVGNt?=
 =?utf-8?B?WlpVME42YldFMVpFdDBPRVJCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJTRUZCUVVGRVlVRlJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJVVUZDUVVGQlFVUlpVWGNyUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VW8wUVVGQlFtNUJSMVZCV0hkQ2FrRkhPRUZpWjBKdFFVZHJRVnBCUW14QlJ6?=
 =?utf-8?B?UkJaRUZDY0VGSFJVRmlRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFXZEJRVUZCUVVGdVowRkJRVWRqUVZwUlFtWkJSMmRCWVZGQ2JrRkhaMEZp?=
 =?utf-8?B?UVVJMVFVZE5RV0ozUW5WQlIxbEJZVkZDYTBGSFZVRmlaMEl3UVVkclFWbFJR?=
 =?utf-8?B?bk5CUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGYWQwSnNRVVk0UVdKblFu?=
 =?utf-8?B?WkJSelJCWTBGQ01VRkhTVUZpUVVKd1FVZE5RVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCUVQwOUlpOCtQQzl0?=
 =?utf-8?B?WlhSaFBnPT0=?=
x-dg-paste: 
x-dg-rorf: true
x-originating-ip: [3.159.212.191]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0026_01D64659.0681C590"
MIME-Version: 1.0
Subject: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 cotscore=-2147483648 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

------=_NextPart_000_0026_01D64659.0681C590
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

James,

> -----Original Message-----
> From: David Woodhouse <dwmw2@infradead.org>
> Sent: December 9, 2019 03:56 AM
> To: James Bottomley <James.Bottomley@HansenPartnership.com>; linux-
> integrity@vger.kernel.org; Wiseman, Monty (GE Global Research, US)
> <monty.wiseman@ge.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>; Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com>
> Subject: EXT: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM
> keys
>
> On Sat, 2019-12-07 at 21:09 -0800, James Bottomley wrote:
> > The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> > key uses.  We've defined three of the available numbers:
> >
> > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Load() operation.
> >
> > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Import() operation.
> >
> > Both loadable and importable keys are specific to a given TPM, the
> > difference is that a loadable key is wrapped with the symmetric
> > secret, so must have been created by the TPM itself.  An importable
> > key is wrapped with a DH shared secret, and may be created without
> > access to the TPM provided you know the public part of the parent key.
> >
> > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > 		bytes) which is sealed by the TPM.  It usually
> > 		represents a symmetric key and must be unsealed before
> > 		use.
>
> Do we still not have an official reference for these that you can
> provide in the commit or the file itself?
>
> It would be very nice to have something more than a verbal assurance
> that they're in Monty's spreadsheet.
>
>
> > Signed-off-by: James Bottomley
> <James.Bottomley@HansenPartnership.com>
> > ---
> >  include/linux/oid_registry.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> > index 657d6bf2c064..a4cee888f9b0 100644
> > --- a/include/linux/oid_registry.h
> > +++ b/include/linux/oid_registry.h
> > @@ -107,6 +107,11 @@ enum OID {
> >  	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
> >  	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
> >
> > +	/* TCG defined OIDS for TPM based keys */
> > +	OID_TPMLoadableKey,		/* 2.23.133.10.1.3 */
> > +	OID_TPMImporableKey,		/* 2.23.133.10.1.4 */
> > +	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
> > +
> >  	OID__NR
> >  };
> >
Bring back an old thread.  We are finally getting the TCG OID registry ready
to publish and wanted to verifier the OIDs you requested and we assigned
above.

I can find 2.23.133.10.1.3 TPM Loadable key in the tpm2-tss-engine project.

I do not see this one, nor the others list above in the kernel source. Did 
these ever
get used? If so, where and can you provide a use case for a relying party?

Also, I have in my local spreadsheet the following which I believe were just
drafts and never assigned. Please confirm.
2.23.133.10.1.1.2
Secondary Identifier: tcg-wellKnownAuthValue

This in intended to be bitmap of well-known authValues. This is not intended
to contain an actual authValue. For example. Bit 1 means and authValue of
hashsize all zeros, Bit 2 means an authValue of hashsize all NULLs, etc.
[Note: Bit 1 is lsb in this notation]

2.23.133.10.1.1.3
No secondary identifier or description

2.23.133.10.1.1.4
No secondary identifier or description


Monty Wiseman
Principal Engineer, Security Architecture
Controls & Optimization

------=_NextPart_000_0026_01D64659.0681C590
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFUEw
ggP2MIIC3qADAgECAhBkgp78Nx50XfyX/5fIsf9BMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQG
EwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNVBAsTFlN5bWFudGVjIFRy
dXN0IE5ldHdvcmsxRTBDBgNVBAMTPFN5bWFudGVjIENsYXNzIDIgUHVibGljIFByaW1hcnkgQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNjAeFw0xMTEwMTgwMDAwMDBaFw0zNzEyMDEyMzU5NTla
MIGUMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNVBAsT
FlN5bWFudGVjIFRydXN0IE5ldHdvcmsxRTBDBgNVBAMTPFN5bWFudGVjIENsYXNzIDIgUHVibGlj
IFByaW1hcnkgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAM3M6QXIY4XLP0BjF70Y+jXmBGdXZZgppE/JXI8PNNL42qgTYqq4HlBneLAW
TKA5qRV6ru3SosDwkDcpGCZc6A08tmxJP8Hg3NlLthQZC6bTluHWCeMZJhz5H2VL+RpDHACD1tCq
SaLU2+ZiOLpQFENt+TH4VhbZOAKRz+ts3bs5TpnhMGdF8dTwjcPf/vI4ByF9AF5WRLPkYL2RK5yr
WwRyD7Io2XKrBSBCJalbA2ogEMwx8CvaNSzQ+5qXTvCCSyvYXzajCy2vYw0dJX+hblxioY0oPqH8
HCD4AS+6VZoRsBnSyFB5aw5qBdeqBDayo/LhX3end5zlHtzp32rBZV0CAwEAAaNCMEAwDgYDVR0P
AQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFIeMIJXImErR1oAGSpA0RN8cTb+w
MA0GCSqGSIb3DQEBCwUAA4IBAQCBjrKlZpa3IaW2728jWl/bgcVCpXjBaf30PNf5XGtwchr8WpdN
AICIiIKKw3ENjsWJmyztjQvSclT1fdRcQ1fp866lAhH2diuBV9192nQw/VRH9uAWbqa0Ckjm53UH
DykZOc559LZsxV+Z1R9L+t9tLDwNVIBw8IgLgM/GaKK4HXDZdoz87qXJz60dz5klV1piRcsWa71J
zaWjjGl5Ja64TGyLQGZLFj/PAhrd4WxrB2FqdhUpmX8b3YiAwb+1j3PFppYjhKYohiQzagEuV3Ml
tl6/j+YdYahAKWcdh5sdf5ufmc0x1lS+Yrs5rGgSSJEgpcux3f5v/FrkglVZrzGpMIIFLjCCBBag
AwIBAgIQcF4q34tlvyELGj6+oYlsHzANBgkqhkiG9w0BAQsFADCBlDELMAkGA1UEBhMCVVMxHTAb
BgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMR8wHQYDVQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3
b3JrMUUwQwYDVQQDEzxTeW1hbnRlYyBDbGFzcyAyIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRp
b24gQXV0aG9yaXR5IC0gRzYwHhcNMTUwNzE2MDAwMDAwWhcNMjUwNzE1MjM1OTU5WjCBqjELMAkG
A1UEBhMCVVMxITAfBgNVBAoTGEdlbmVyYWwgRWxlY3RyaWMgQ29tcGFueTEfMB0GA1UECxMWU3lt
YW50ZWMgVHJ1c3QgTmV0d29yazE1MDMGA1UECxMsQ2xhc3MgMiBNYW5hZ2VkIFBLSSBJbmRpdmlk
dWFsIFN1YnNjcmliZXIgQ0ExIDAeBgNVBAMTF0dFIFNNSU1FIElzc3VpbmcgQ0EgMi4xMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA378J1PLIrR/ohqKy2XP+/XTYM6xUpLcgkQXq43hM
EsDxRFCHlylstDY5DNBZYdG3/ZOXvf8vkhCLPKbbr6s1vWYPSQJZa4+J76H5et2gNHyt04lFXSJl
TEblZ4Q9tfeY60M2SgcQpjMqhXZLQC9keFqjq1bXJtE4ojeYV43uOqmOP+xVhDh1cxNmcyx+ouxr
nWqGeTtIXtjaV1hysVOAEhM695yKLAAOD/w05B/IT2BvFSZo70oewZ75sDilb8p8yijKs4a66zk2
i8nzHlxa7smh/SGOOSmb95saELi/LatPoSV61otzZc6/oIyENvNUZBAKDh+vAo0P+rCJVaBcsQID
AQABo4IBYjCCAV4wEgYDVR0TAQH/BAgwBgEB/wIBADBsBgNVHSAEZTBjMGEGC2CGSAGG+EUBBxcC
MFIwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vY3BzMCgGCCsGAQUFBwICMBwa
Gmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vcnBhMA4GA1UdDwEB/wQEAwIBBjAvBgNVHR8EKDAmMCSg
IqAghh5odHRwOi8vcy5zeW1jYi5jb20vcGNhMi1nNi5jcmwwLgYIKwYBBQUHAQEEIjAgMB4GCCsG
AQUFBzABhhJodHRwOi8vcy5zeW1jZC5jb20wKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVN5bWFu
dGVjUEtJLTItMTYzMB0GA1UdDgQWBBQvKSLom9uJQ+72kqCQqqtlspFuzjAfBgNVHSMEGDAWgBSH
jCCVyJhK0daABkqQNETfHE2/sDANBgkqhkiG9w0BAQsFAAOCAQEAsA1GZHwSB80BNyzRwXOS+NY+
Bi7rqMZFlspgqzzctnenM1aDVAvDLt9rOHQ6EUTeIRjsI2eVPQsLbgWgDe9AMFo+xq2wmer5jI+l
Kbg6lQycCa/avY9ryO1zJRAkJouihXd6Q6wakcRxZOFK6WaBSW/r0FWB67h/7J1fgRM+Zmz5ZDAF
cutH5GLdjqTUpuKMr/v5hNXiKSoh2Z3ahJMWJssiamtOyL4nku8H6B3Gf8rWUL/lfnJIVPqQ7EXf
r2AbftAipM9Ohl2jZ/4hcBWJhHTU04AVFzkEUqNEH5bKtzIpef8HsFtufAM+KUV6zU6/HrhYWvGd
+h0SITG6SkdilzCCBfowggTioAMCAQICED8rJ5qvtlE8Q9PcqQpuAMYwDQYJKoZIhvcNAQELBQAw
gaoxCzAJBgNVBAYTAlVTMSEwHwYDVQQKExhHZW5lcmFsIEVsZWN0cmljIENvbXBhbnkxHzAdBgNV
BAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxNTAzBgNVBAsTLENsYXNzIDIgTWFuYWdlZCBQS0kg
SW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMSAwHgYDVQQDExdHRSBTTUlNRSBJc3N1aW5nIENBIDIu
MTAeFw0xOTA4MjYwMDAwMDBaFw0yMjA4MjUyMzU5NTlaMHYxITAfBgNVBAoMGEdlbmVyYWwgRWxl
Y3RyaWMgQ29tcGFueTEjMCEGCSqGSIb3DQEJARYUbW9udHkud2lzZW1hbkBnZS5jb20xEjAQBgNV
BEEMCTIxMjU3NjI1OTEYMBYGA1UEAwwPV2lsbGFyZCBXaXNlbWFuMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAzrUXmmQ8HYedVE4i0h8hqPzDPRbc1iuQo4Wn3WC1qX5ECdCcaVljj6p4
JrX4zptulRTQc/WCeyCQ5uMSsQKL84MsJSYR5zHAUZy+djMXHPZakef3nyJ2A5cfMIhbki6u4dna
UA4oDIANbcYV3t8XlGAHstosKQajbTGawWFCOKbteKrcS5khuM+MPmSKbM2ROXzCGvKy323iMAg3
VTxmGGx08Y0xOKYikoXIcvGLyCswhR8UFESgeUw8LhXvW7dQ9PI7g1YMxcBLldkBiqgAugiKhC9H
FB0SfssQq21L6n0RJb3GCwGagvaC9DgHFbxppwOFflTjKGNm+pKB47XRhQIDAQABo4ICTTCCAkkw
DAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCBSAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwQwHQYD
VR0OBBYEFFaFSmgtcRDwfRFiqt3Vq8LJCLn5MB8GA1UdEQQYMBaBFG1vbnR5Lndpc2VtYW5AZ2Uu
Y29tMGwGA1UdIARlMGMwYQYLYIZIAYb4RQEHFwIwUjAmBggrBgEFBQcCARYaaHR0cDovL3d3dy5z
eW1hdXRoLmNvbS9jcHMwKAYIKwYBBQUHAgIwHBoaaHR0cDovL3d3dy5zeW1hdXRoLmNvbS9ycGEw
XQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL3BraS1jcmwuc3ltYXV0aC5jb20vY2FfYTVjOGZlZDVh
NTA5ZWY5OThiYmU4ZTI2YzIzMjc5MTkvTGF0ZXN0Q1JMLmNybDA3BggrBgEFBQcBAQQrMCkwJwYI
KwYBBQUHMAGGG2h0dHA6Ly9wa2ktb2NzcC5zeW1hdXRoLmNvbTAfBgNVHSMEGDAWgBQvKSLom9uJ
Q+72kqCQqqtlspFuzjBCBgkqhkiG9w0BCQ8ENTAzMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAEqMCsGCmCGSAGG+EUBEAMEHTAbBhJghkgBhvhFARABAgII
AbDX1HsWBTU4ODgzMDkGCmCGSAGG+EUBEAUEKzApAgEAFiRhSFIwY0hNNkx5OXdhMmt0Y21FdWMz
bHRZWFYwYUM1amIyMD0wDQYJKoZIhvcNAQELBQADggEBAMT8DZQmw1h5uoIIu24KRKVwoKIAsK8a
4VfdXPwU3Ic/B4Yb9ZlgqhlfErEm9YLOeG9AAR61P5J7i4UM+airUKWSv5u/JLl0WZLgIfsqW09v
MGLsHUZmanaIrYIFJUzXj3Tn9bro6d9lsAZ9SXf9h+2SUeNnPrurrtdQBYO9DCKcV2s923IrQu6V
q1JuJF1ILYpClTRmdsDYanAhn4+KNff9KGrFf7PnLvuakYqRMTP3+Z31mzJGPr1QTMeK7KfqerR8
zcxuOmoD3t46pYpvrqFzdw5jMq08VKPMwIQzhhNLTzUvBf5nEvwV2LeW7+Kq/SaxbL2pJKlEP1aj
YD7Z9VAwggYTMIIE+6ADAgECAhAegUVrOLZID1iw+usLAIEKMA0GCSqGSIb3DQEBCwUAMIGqMQsw
CQYDVQQGEwJVUzEhMB8GA1UEChMYR2VuZXJhbCBFbGVjdHJpYyBDb21wYW55MR8wHQYDVQQLExZT
eW1hbnRlYyBUcnVzdCBOZXR3b3JrMTUwMwYDVQQLEyxDbGFzcyAyIE1hbmFnZWQgUEtJIEluZGl2
aWR1YWwgU3Vic2NyaWJlciBDQTEgMB4GA1UEAxMXR0UgU01JTUUgSXNzdWluZyBDQSAyLjEwHhcN
MTkwODI2MDAwMDAwWhcNMjIwODI1MjM1OTU5WjCBjjEhMB8GA1UECgwYR2VuZXJhbCBFbGVjdHJp
YyBDb21wYW55MRYwFAYDVQQLDA1NVUxUSS1BTExPV0VEMSMwIQYJKoZIhvcNAQkBFhRtb250eS53
aXNlbWFuQGdlLmNvbTESMBAGA1UEQQwJMjEyNTc2MjU5MRgwFgYDVQQDDA9XaWxsYXJkIFdpc2Vt
YW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4NvBCFy+DSWEcMD9TuUpytVnqan5T
6KWuYKMwaZvZ1ZGRpEt4ZgHmgZ91yVcvAqKs2iBHVsDjZgHRjxo2qbEonstUAc2fUPFpg2bq6W4n
5olP/2mULgF15/QHK52rzVzz7bd9PrNo0AfCYJlnL6lQMEoAm353L0puny3t3dDgfQ7mlr9uOu3A
BgWxDzC3dKqoK+/ExI8287CENBrdkzF5AAU+swC9HcgLWjIyk2ycVdAKF11NxV/M4Ib5tW+KakVH
L3F+y7oK8UsQ8kmDIT9tnmq5RpI0u4es4KeVpxEWLTKBNJgT98CSRPsVkgr+jFeGhHVVOiDoEWfq
77n0tA9ZAgMBAAGjggJNMIICSTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIGwDAWBgNVHSUB
Af8EDDAKBggrBgEFBQcDBDAdBgNVHQ4EFgQUOMebpxvpg46npDMIZXT0FdS1uSswHwYDVR0RBBgw
FoEUbW9udHkud2lzZW1hbkBnZS5jb20wbAYDVR0gBGUwYzBhBgtghkgBhvhFAQcXAjBSMCYGCCsG
AQUFBwIBFhpodHRwOi8vd3d3LnN5bWF1dGguY29tL2NwczAoBggrBgEFBQcCAjAcGhpodHRwOi8v
d3d3LnN5bWF1dGguY29tL3JwYTBdBgNVHR8EVjBUMFKgUKBOhkxodHRwOi8vcGtpLWNybC5zeW1h
dXRoLmNvbS9jYV9hNWM4ZmVkNWE1MDllZjk5OGJiZThlMjZjMjMyNzkxOS9MYXRlc3RDUkwuY3Js
MDcGCCsGAQUFBwEBBCswKTAnBggrBgEFBQcwAYYbaHR0cDovL3BraS1vY3NwLnN5bWF1dGguY29t
MB8GA1UdIwQYMBaAFC8pIuib24lD7vaSoJCqq2WykW7OMEIGCSqGSIb3DQEJDwQ1MDMwCgYIKoZI
hvcNAwcwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBFjALBglghkgBZQMEASowKwYKYIZIAYb4RQEQ
AwQdMBsGEmCGSAGG+EUBEAECAgcBsNfTCxYFNTg4ODMwOQYKYIZIAYb4RQEQBQQrMCkCAQAWJGFI
UjBjSE02THk5d2Eya3RjbUV1YzNsdFlYVjBhQzVqYjIwPTANBgkqhkiG9w0BAQsFAAOCAQEAtGYc
0qmQ2dR17GsN4S3s5bKXiykNWQXj1pt2i1AQ3igaVd+4VkSfNTU+dKLJrcnuA9ZNoBejHDuIeTrz
ZnAdOI2yk3yyLTl5JfaSyDUzRklp7AwRxZo/GwpBTs1A8j8MsT+4M6zYhJetYTGeXLBv/uwHhwgJ
p4dgosH0u3Aia9UlnThAWbXMTfcBIiHykU1QAPTfYhFuGOjLvRL1X9KXaFCqZ0ld72Dn3ygb3Tpx
FNbk+dXpVj4JMceKoxFHlcfCsqN0p6s6VR5yt+NZohPr+UUf93rgLmjm3iSjOmVHQFIBYdwNVgWZ
57k0kFdRv0gQBJzvS6noNT1cepl4CZL3MjGCBJYwggSSAgEBMIG/MIGqMQswCQYDVQQGEwJVUzEh
MB8GA1UEChMYR2VuZXJhbCBFbGVjdHJpYyBDb21wYW55MR8wHQYDVQQLExZTeW1hbnRlYyBUcnVz
dCBOZXR3b3JrMTUwMwYDVQQLEyxDbGFzcyAyIE1hbmFnZWQgUEtJIEluZGl2aWR1YWwgU3Vic2Ny
aWJlciBDQTEgMB4GA1UEAxMXR0UgU01JTUUgSXNzdWluZyBDQSAyLjECEB6BRWs4tkgPWLD66wsA
gQowDQYJYIZIAWUDBAIBBQCgggKnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIwMDYxOTIwNDUyMlowLwYJKoZIhvcNAQkEMSIEIFf1B4A5b7DegBS8X+1dCfgOHmsy
aRR7PMKE73XD0JnYMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAcGBSsOAwIaMIHQBgkrBgEE
AYI3EAQxgcIwgb8wgaoxCzAJBgNVBAYTAlVTMSEwHwYDVQQKExhHZW5lcmFsIEVsZWN0cmljIENv
bXBhbnkxHzAdBgNVBAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxNTAzBgNVBAsTLENsYXNzIDIg
TWFuYWdlZCBQS0kgSW5kaXZpZHVhbCBTdWJzY3JpYmVyIENBMSAwHgYDVQQDExdHRSBTTUlNRSBJ
c3N1aW5nIENBIDIuMQIQPysnmq+2UTxD09ypCm4AxjCB0gYLKoZIhvcNAQkQAgsxgcKggb8wgaox
CzAJBgNVBAYTAlVTMSEwHwYDVQQKExhHZW5lcmFsIEVsZWN0cmljIENvbXBhbnkxHzAdBgNVBAsT
FlN5bWFudGVjIFRydXN0IE5ldHdvcmsxNTAzBgNVBAsTLENsYXNzIDIgTWFuYWdlZCBQS0kgSW5k
aXZpZHVhbCBTdWJzY3JpYmVyIENBMSAwHgYDVQQDExdHRSBTTUlNRSBJc3N1aW5nIENBIDIuMQIQ
Pysnmq+2UTxD09ypCm4AxjANBgkqhkiG9w0BAQEFAASCAQAU1VK9MVU/Nf6yE2wGwcnHS9KJ4+Ry
lyJviW4WmkiVDctSpi6PBxTeOXTXgqfDrq3B9VgvU1cDBKFelRLEjywASnIJy0m8UIX4bjPY9g2F
ueH50J8xeEM91KrbXmsWgbihYMnc2jnf92m39aWRorrHUufB43v3uhED3K3JJxqk2nKLt8K+9U3V
4U/3858QmREixcg6xFn5JQBXBAm1U8GHoOe6oqvhcbSUljLQGCZq4IObeych2yzON9xwUCwIK484
w5CJnP7tImlCWniMCCbHfk0ZF2Iu+cbDl/il0MkQvHF7TA92an8L+2W+OCTGnEWDX26UwFlEOHOk
42cSqugPAAAAAAAA

------=_NextPart_000_0026_01D64659.0681C590--
