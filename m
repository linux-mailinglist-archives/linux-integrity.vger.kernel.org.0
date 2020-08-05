Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9923CC77
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHEQra (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 12:47:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHEQpn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:45:43 -0400
Received: from static-50-53-58-29.bvtn.or.frontiernet.net ([50.53.58.29] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1k3MXp-0000Xu-4e; Wed, 05 Aug 2020 16:45:37 +0000
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <20200805004331.20652-2-nramas@linux.microsoft.com>
 <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
 <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
 <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
 <CAEjxPJ6X+Cqd5QtZBmNm2cujwbg-STfRF7_8i=Ny8yuc6z9BwQ@mail.gmail.com>
 <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
 <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
 <20200805150732.GA4365@sequoia>
 <39390a53-51df-12f0-5451-e677ccca581a@gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <d9ea5ada-7b6a-057e-a532-3ce7688b4d1e@canonical.com>
Date:   Wed, 5 Aug 2020 09:45:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <39390a53-51df-12f0-5451-e677ccca581a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/20 8:43 AM, Stephen Smalley wrote:
> On 8/5/20 11:07 AM, Tyler Hicks wrote:
> 
>> On 2020-08-05 10:27:43, Stephen Smalley wrote:
>>> On Wed, Aug 5, 2020 at 9:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>> On Wed, 2020-08-05 at 09:03 -0400, Stephen Smalley wrote:
>>>>> On Wed, Aug 5, 2020 at 8:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>>> On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
>>>>>>> On 8/4/20 11:25 PM, Mimi Zohar wrote:
>>>>>>>
>>>>>>>> Hi Lakshmi,
>>>>>>>>
>>>>>>>> There's still  a number of other patch sets needing to be reviewed
>>>>>>>> before my getting to this one.  The comment below is from a high level.
>>>>>>>>
>>>>>>>> On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
>>>>>>>>> Critical data structures of security modules need to be measured to
>>>>>>>>> enable an attestation service to verify if the configuration and
>>>>>>>>> policies for the security modules have been setup correctly and
>>>>>>>>> that they haven't been tampered with at runtime. A new IMA policy is
>>>>>>>>> required for handling this measurement.
>>>>>>>>>
>>>>>>>>> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
>>>>>>>>> measure the state and the policy provided by the security modules.
>>>>>>>>> Update ima_match_rules() and ima_validate_rule() to check for
>>>>>>>>> the new func and ima_parse_rule() to handle the new func.
>>>>>>>> I can understand wanting to measure the in kernel LSM memory state to
>>>>>>>> make sure it hasn't changed, but policies are stored as files.  Buffer
>>>>>>>> measurements should be limited  to those things that are not files.
>>>>>>>>
>>>>>>>> Changing how data is passed to the kernel has been happening for a
>>>>>>>> while.  For example, instead of passing the kernel module or kernel
>>>>>>>> image in a buffer, the new syscalls - finit_module, kexec_file_load -
>>>>>>>> pass an open file descriptor.  Similarly, instead of loading the IMA
>>>>>>>> policy data, a pathname may be provided.
>>>>>>>>
>>>>>>>> Pre and post security hooks already exist for reading files.   Instead
>>>>>>>> of adding IMA support for measuring the policy file data, update the
>>>>>>>> mechanism for loading the LSM policy.  Then not only will you be able
>>>>>>>> to measure the policy, you'll also be able to require the policy be
>>>>>>>> signed.
>>>>>>> To clarify, the policy being measured by this patch series is a
>>>>>>> serialized representation of the in-memory policy data structures being
>>>>>>> enforced by SELinux.  Not the file that was loaded.  Hence, this
>>>>>>> measurement would detect tampering with the in-memory policy data
>>>>>>> structures after the policy has been loaded.  In the case of SELinux,
>>>>>>> one can read this serialized representation via /sys/fs/selinux/policy.
>>>>>>> The result is not byte-for-byte identical to the policy file that was
>>>>>>> loaded but can be semantically compared via sediff and other tools to
>>>>>>> determine whether it is equivalent.
>>>>>> Thank you for the clarification.   Could the policy hash be included
>>>>>> with the other critical data?  Does it really need to be measured
>>>>>> independently?
>>>>> They were split into two separate functions because we wanted to be
>>>>> able to support using different templates for them (ima-buf for the
>>>>> state variables so that the measurement includes the original buffer,
>>>>> which is small and relatively fixed-size, and ima-ng for the policy
>>>>> because it is large and we just want to capture the hash for later
>>>>> comparison against known-good).  Also, the state variables are
>>>>> available for measurement always from early initialization, whereas
>>>>> the policy is only available for measurement once we have loaded an
>>>>> initial policy.
>>>> Ok, measuring the policy separately from other critical data makes
>>>> sense.  Instead of measuring the policy, which is large, measure the
>>>> policy hash.
>>> I think that was the original approach.  However, I had concerns with
>>> adding code to SELinux to compute a hash over the policy versus
>>> leaving that to IMA's existing policy and mechanism.  If that's
>>> preferred I guess we can do it that way but seems less flexible and
>>> duplicative.
>> In AppArmor, we store the sha1 of the raw policy as the policy is
>> loaded. The hash is exposed to userspace in apparmorfs. See commit
>> 5ac8c355ae00 ("apparmor: allow introspecting the loaded policy pre
>> internal transform").
>>
>> It has proved useful as a mechanism for debugging as sometimes the
>> on-disk policy doesn't match the loaded policy and this can be a good
>> way to check that while providing support to users. John also mentions
>> checkpoint/restore in the commit message and I could certainly see how
>> the policy hashes would be useful in that scenario.
>>
>> When thinking through how Lakshmi's series could be extended for
>> AppArmor support, I was thinking that the AppArmor policy measurement
>> would be a measurement of these hashes that we already have in place.
>>
>> Perhaps there's some general usefulness in storing/exposing an SELinux
>> policy hash rather than only seeing it as duplicative property required
>> this measurement series?
> 
> That would be a hash of the policy file that was last loaded via the selinuxfs interface for loading policy, not a hash of the in-memory policy data structures at the time of measurement (which is what this patch series is implementing).  The duplicative part is with respect to selecting a hash algorithm and hashing the in-memory policy as part of the SELinux code rather than just passing the policy buffer to IMA for measurement like any other buffer.  Userspace can already hash the in-memory policy data itself by running sha256sum or whatever on /sys/fs/selinux/policy, so we don't need to save or expose that separately.
> 
> 

yeah apparmor exposes full loaded policy data that userspace could hash independently too, the hashing done by the kernel just reduces the amount of data that userspace has to suck down if they trust the kernel to do the hash. Those hashes are also used by apparmor internally for the first part of a dedup check so exposing them cost very little.

The hashing of the in-memory data structures and variables is something we are not currently doing. If we were to do it hashing in-memory apparmor policy would be quite involved and that would be something I would rather have LSMs export an interface for rather than having IMA poke directly at the data structures (ie. apparmor specific code in apparmor).

As for computing a measurement based on the hash instead of the in-memory policy, while quicker that would not detect memory corruption/attacks that manage to modify policy via writing kernel memory. Whether that type of measurement is sufficient depends on what you are trying to achieve.


